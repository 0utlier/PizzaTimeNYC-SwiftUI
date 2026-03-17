import SwiftUI

// MARK: - PizzaRefreshHeader

struct PizzaRefreshHeader: View {

    let phase: RefreshPhase
    let pullProgress: CGFloat

    // ── Animation state ───────────────────────────────────────────────────────
    // We only need State for the spin and fade — those are triggered once on a
    // phase change and then run on their own. The X offsets are computed live
    // from pullProgress (see below) so they DON'T need to be @State variables.
    @State private var isSpinning: Bool = false
    @State private var headerOpacity: Double = 1.0

    // MARK: - Computed Offsets
    //
    // KEY CHANGE from previous version:
    // Instead of storing pizzaX / dollarX in @State and updating them inside
    // onChange(of: phase), we compute them directly in the view body.
    //
    // Why does this matter?
    // onChange(of: phase) fires ONCE when phase transitions (e.g. idle → pulling).
    // It does NOT fire again while the phase stays at .pulling, even though
    // pullProgress is changing every frame as the user drags.
    //
    // Computed properties recalculate on every view render. Because pullProgress
    // is a let (passed from the parent which itself re-renders on each scroll
    // tick), SwiftUI will re-evaluate these properties — and therefore reposition
    // the icons — on every single drag frame.
    //
    // .pulling  → scrub from ±50 toward 0 proportional to how far they've dragged
    // .triggered / .refreshing → snap to 0 (spring is applied via .animation below)
    // .snapping / .idle → stay at 0 (opacity handles the visual disappearance)

    private var pizzaOffsetX: CGFloat {
        switch phase {
        case .idle:                              return -50
        case .pulling:                           return -50 * (1 - pullProgress)  // live scrub
        case .triggered, .refreshing, .snapping: return 0
        }
    }

    private var dollarOffsetX: CGFloat {
        switch phase {
        case .idle:                              return  50
        case .pulling:                           return  50 * (1 - pullProgress)  // live scrub
        case .triggered, .refreshing, .snapping: return 0
        }
    }

    // ─────────────────────────────────────────────────────────────────────────

    var body: some View {
        ZStack {

            // ── Dollar Bill ─────────────────────────────────────────────────
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 0.13, green: 0.54, blue: 0.13))
                .frame(width: 64, height: 32)
                .overlay(Text("💵").font(.system(size: 20)))
                .offset(x: dollarOffsetX)
                // .animation with value: phase means the spring only kicks in when
                // the PHASE changes (e.g. pulling → triggered). During .pulling,
                // phase stays the same, so no spring fires — the icon just tracks
                // the finger directly, which is exactly what we want.
                .animation(.spring(response: 0.35, dampingFraction: 0.65), value: phase)

            // ── Pizza ────────────────────────────────────────────────────────
            Circle()
                .fill(Color.orange)
                .frame(width: 42, height: 42)
                .overlay(Text("🍕").font(.system(size: 24)))
                .offset(x: pizzaOffsetX)
                .animation(.spring(response: 0.35, dampingFraction: 0.65), value: phase)
        }
        // ── Spin ─────────────────────────────────────────────────────────────
        // Rotates the entire ZStack (pizza + dollar as one unit).
        // isSpinning is toggled by onChange below, not by computed props —
        // the spin needs to keep going regardless of pullProgress.
        .rotationEffect(.degrees(isSpinning ? 360 : 0), anchor: .center)
        .animation(
            isSpinning
                ? .linear(duration: 0.85).repeatForever(autoreverses: false)
                : .easeOut(duration: 0.2),
            value: isSpinning
        )
        .opacity(headerOpacity)
        .frame(height: 70)

        // ── Phase change side-effects ─────────────────────────────────────────
        // onChange is now ONLY responsible for the spin and fade — things that
        // need to fire once and then run independently. Offset positioning has
        // been moved out of here entirely.
        .onChange(of: phase, perform: handlePhaseChange)
    }

    // MARK: - Phase Side-Effects

    private func handlePhaseChange(_ newPhase: RefreshPhase) {
        switch newPhase {

        case .idle, .pulling:
            // Nothing to do — offsets are driven by computed props above,
            // and we only reset opacity/spin state in .snapping.
            break

        case .triggered, .refreshing:
            // Icons have now snapped to center (via the computed offset + spring).
            // Wait for the spring to settle, then start spinning.
            headerOpacity = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                isSpinning = true
            }

        case .snapping:
            // Stop spin and fade out.
            isSpinning = false
            withAnimation(.easeOut(duration: 0.25)) {
                headerOpacity = 0.0
            }
            // Reset opacity for the next pull cycle.
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                headerOpacity = 1.0
            }
        }
    }
}
