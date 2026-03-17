import SwiftUI

// MARK: - ScrollOffsetPreferenceKey
// PreferenceKeys are SwiftUI's mechanism for passing data from a CHILD view
// UP to a PARENT view — the opposite of normal top-down data flow.
//
// Here we use one to bubble up the scroll position of an invisible anchor
// view so the parent (RefreshableScrollView) can react to how far the user
// has pulled down.
struct ScrollOffsetPreferenceKey: PreferenceKey {

    // The value when nothing has reported yet
    static var defaultValue: CGFloat = 0

    // `reduce` is called when multiple children report values.
    // We only have one anchor, so we just take whatever the next value is.
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


// MARK: - RefreshableScrollView
// A drop-in replacement for ScrollView that adds custom pull-to-refresh.
//
// How it works at a high level:
//   1. An invisible GeometryReader is placed at the very top of the scroll content.
//   2. When the user pulls down, that anchor view's Y position goes positive.
//   3. We read that Y position via the PreferenceKey and compare it to `threshold`.
//   4. Once the threshold is crossed, we trigger `action`, show the header, and wait.
//   5. When `action` finishes, we animate the header back up and return to idle.
//
// Generic over Content so callers can pass in any view hierarchy via @ViewBuilder.
struct RefreshableScrollView<Content: View>: View {

    // The async work to do when a refresh is triggered.
    // Typically this is a ViewModel call like `await viewModel.fetchRestaurants()`.
    let action: () async -> Void

    // The scroll view's content. @ViewBuilder lets callers write natural SwiftUI
    // syntax inside the trailing closure, just like a regular ScrollView.
    @ViewBuilder let content: Content

    // ── Configuration ─────────────────────────────────────────────────────────

    // How many points the user must pull before a refresh fires.
    // 80 pt is roughly one thumb-width and feels natural on iPhone.
    private let threshold: CGFloat = 80

    // How tall the refresh header is while loading is in progress.
    // This must match the .frame(height:) in PizzaRefreshHeader.
    private let headerHeight: CGFloat = 70

    // ── State ─────────────────────────────────────────────────────────────────

    // The single source of truth for the animation — see RefreshPhase enum.
    @State private var phase: RefreshPhase = .idle

    // The raw Y offset of the invisible anchor view. Positive = pulled down.
    @State private var scrollOffset: CGFloat = 0

    // Extra top padding injected below the header while loading is active.
    // This keeps the list content from jumping up over the header mid-spin.
    @State private var topPadding: CGFloat = 0

    // ── Computed ──────────────────────────────────────────────────────────────

    // How far (0.0–1.0) the user has pulled toward the threshold.
    // Passed to PizzaRefreshHeader so it can scrub the icon positions.
    // When we're not in .pulling phase, clamp to 0 or 1 as appropriate.
    private var pullProgress: CGFloat {
        switch phase {
        case .idle:                     return 0
        case .pulling:                  return min(scrollOffset / threshold, 1.0)
        case .triggered, .refreshing,
             .snapping:                 return 1
        }
    }

    // ─────────────────────────────────────────────────────────────────────────

    var body: some View {

        // coordinateSpace(name:) gives us a named reference frame.
        // The GeometryReader inside will measure its position RELATIVE to this
        // scroll view, not the entire screen — that's what makes the offset math work.
        ScrollView {
            VStack(spacing: 0) {

                // ── Refresh Header ─────────────────────────────────────────
                // Only insert the header view into the layout when something is
                // actually happening. Keeping it out of the hierarchy during .idle
                // means zero layout cost when the user isn't pulling.
                if phase != .idle {
                    PizzaRefreshHeader(phase: phase, pullProgress: pullProgress)
                        .frame(height: headerHeight)
                        // .clipped() prevents the icons from visually overflowing
                        // the header area during the slide-in animation.
                        .clipped()
                }

                // ── Invisible Offset Anchor ────────────────────────────────
                // This GeometryReader has zero height so it takes up no space.
                // Its only purpose is to read its own position in the named
                // coordinate space and report it upward via the PreferenceKey.
                //
                // At rest (scroll at top): minY == 0
                // Pulled down by 50 pts:   minY == 50
                // Scrolled up into content: minY < 0 (we ignore negatives)
                GeometryReader { geo in
                    Color.clear
                        .preference(
                            key: ScrollOffsetPreferenceKey.self,
                            value: geo.frame(in: .named("pizzaScroll")).minY
                        )
                }
                .frame(height: 0)

                // ── Caller's Content ───────────────────────────────────────
                // This is the ForEach / List / LazyVStack etc. passed by the caller.
                content
            }
            // Dynamically grow the top padding to hold the header open while loading.
            // withAnimation is applied at the call site for precise timing control.
            .padding(.top, topPadding)
        }
        .coordinateSpace(name: "pizzaScroll")

        // ── Listen for offset changes ──────────────────────────────────────
        // Every time the anchor view reports a new Y value, we run the logic below.
        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { newOffset in
            scrollOffset = newOffset
            handleScrollOffset(newOffset)
        }
    }

    // MARK: - Scroll Offset Logic

    private func handleScrollOffset(_ offset: CGFloat) {

        // While refreshing or collapsing, the scroll position can change due to
        // padding adjustments. Ignore those changes — we don't want them to
        // accidentally re-trigger the pull logic.
        guard phase == .idle || phase == .pulling else { return }

        if offset <= 0 {
            // The user scrolled back up or released before the threshold.
            // Return quietly to idle.
            if phase == .pulling {
                phase = .idle
            }
            return
        }

        if offset >= threshold {
            // ── Threshold crossed → trigger refresh ────────────────────────
            // Lock the phase so further offset changes don't re-enter this branch.
            phase = .refreshing

            // Push the list content down so the header stays visible.
            // The spring animation makes the "lock in" feel physical.
            withAnimation(.spring(response: 0.3, dampingFraction: 0.72)) {
                topPadding = headerHeight
            }

            // Launch the caller's async work on a new Task.
            // Task {} on MainActor is safe here because `action` is async and
            // will suspend when it does network I/O, keeping the UI responsive.
            Task {
                await action()
                // `finishRefresh` must run on the main thread to update @State.
                await finishRefresh()
            }

        } else {
            // ── Still pulling — update pull progress ───────────────────────
            // Setting phase to .pulling every frame is fine; SwiftUI diffing
            // will no-op the re-render if nothing meaningful changed.
            phase = .pulling
        }
    }

    // MARK: - Finish Refresh

    // Called on MainActor (via `await`) so all @State mutations are safe.
    @MainActor
    private func finishRefresh() async {

        // Small grace period so the spin animation feels conclusive rather than
        // snapping off the moment the last byte arrives.
        try? await Task.sleep(nanoseconds: 350_000_000)  // 0.35 s

        // Signal the header to fade out and stop spinning.
        phase = .snapping

        // Slide the padding back to zero — this pulls the list content back up.
        withAnimation(.spring(response: 0.4, dampingFraction: 0.78)) {
            topPadding = 0
        }

        // Wait for the collapse + fade animation to finish before going fully idle.
        // Going idle removes PizzaRefreshHeader from the view hierarchy,
        // which is fine because the fade has already hidden it visually.
        try? await Task.sleep(nanoseconds: 450_000_000)  // 0.45 s
        phase = .idle
    }
}


// MARK: - Usage Example (delete before shipping)
//
// struct RestaurantListView: View {
//     @StateObject var viewModel = RestaurantViewModel()
//
//     var body: some View {
//         RefreshableScrollView {
//             // ← your async data-fetch goes here
//             await viewModel.fetchRestaurants()
//         } content: {
//             LazyVStack(spacing: 0) {
//                 ForEach(viewModel.restaurants) { restaurant in
//                     RestaurantRow(restaurant: restaurant)
//                 }
//             }
//         }
//     }
// }
