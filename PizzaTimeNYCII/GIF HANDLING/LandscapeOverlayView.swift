//
//  LandscapeOverlayView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/9/26.
//

import SwiftUI

struct LandscapeOverlayView: View {
    @EnvironmentObject var orientationObserver: OrientationObserver
    var arrayOfGifs: [String] = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            GIFView(name: selectedGif)
                .rotationEffect(.degrees(orientationObserver.landscapeAngle))
        }
        .transition(.opacity.animation(.easeInOut(duration: 0.3)))
        .statusBarHidden(orientationObserver.isLandscape)
    }

    // Your gif-sorting logic lives here, close to where it's used
    private var selectedGif: String {
        // sort through gifs and return the right one
        return arrayOfGifs.randomElement() ?? "DancingPizzaAlpha"
        
    }
}
