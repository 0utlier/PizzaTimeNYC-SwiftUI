//
//  PizzaTimeNYCIIApp.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/10/26.
//

import SwiftUI
import Combine

class MusicState: ObservableObject {
    @Published var isPlaying: Bool = false
}

@main
struct PizzaTimeNYCIIApp: App {
    @StateObject private var isPlaying = MusicState()
    var body: some Scene {
        WindowGroup {
            AddPage()
                .environmentObject(isPlaying)
        }
    }
}
