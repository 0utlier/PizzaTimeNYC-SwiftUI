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
    @State private var currentPage = [Int]()
}

class NavigationManager: ObservableObject {
    @Published var activePage: PizzaPage?
    @Published var lastPage: PizzaPage? = nil
    
    // trigger refresh
//    @Published var refreshID = UUID()
    
    func goHome() {
        print("Going home sir...")
        lastPage = activePage
        activePage = nil
//        refreshID = UUID() // trigger view refresh
    }
}

@main
struct PizzaTimeNYCIIApp: App {
    @StateObject var isPlaying = MusicState()
    //    @State private var activePage: PizzaPage?
    @StateObject var nav = NavigationManager()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(isPlaying)
            .environmentObject(nav)
        }
    }
}
