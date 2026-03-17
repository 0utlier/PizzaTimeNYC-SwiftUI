//
//  RefreshPhase.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/17/26.
//

import Foundation

// MARK: - RefreshPhase
// Single source of truth for the pull-to-refresh lifecycle.
// Both RefreshableScrollView (which drives the phase) and
// PizzaRefreshHeader (which reacts to it) import this type.
enum RefreshPhase: Equatable {
    case idle           // Nothing happening. Header is hidden.
    case pulling        // User is dragging but hasn't hit the threshold yet.
    case triggered      // Threshold crossed — release will fire a refresh.
    case refreshing     // Data is actively loading.
    case snapping       // Loading done — header is collapsing back up.
}
