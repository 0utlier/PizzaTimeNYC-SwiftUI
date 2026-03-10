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
    //    @State private var currentPage = [Int]()
}

class NavigationManager: ObservableObject {
    @Published var activePage: PizzaPage?
    @Published var lastPage: PizzaPage? = nil
    
    func goHome() {
        print("Going home sir...")
        lastPage = activePage
        activePage = nil
    }
}

class OrientationObserver: ObservableObject {
    @Published var isLandscape: Bool = false
    @Published var isFaceDown: Bool = false
    @Published var landscapeAngle: Double = 90
    
    init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
    }
    @objc private func orientationChanged() {
        let orientation = UIDevice.current.orientation
        isLandscape = orientation == .landscapeLeft || orientation == .landscapeRight
        isFaceDown = orientation == .faceDown
        
        if orientation == .landscapeLeft {
            landscapeAngle = 90
        } else if orientation == .landscapeRight {
            landscapeAngle = -90
        }
        
        print("islanscape: \(isLandscape) - rotate: \(landscapeAngle)")
        print("isfacedown: \(isFaceDown)")
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}

@main
struct PizzaTimeNYCIIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var orientationObserver = OrientationObserver()
    @StateObject var isPlaying = MusicState()
    //    @State private var activePage: PizzaPage?
    @StateObject var nav = NavigationManager()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .overlay {
                        if orientationObserver.isLandscape {
                            LandscapeOverlayView()
                                .environmentObject(orientationObserver)
                        }
                    }
            }
            .preferredColorScheme(.light) // don't allow dark mode to change any colors

            .environmentObject(isPlaying)
            .environmentObject(nav)
            .onChange(of: orientationObserver.isFaceDown) { faceDown in
                if faceDown {
                    isPlaying.isPlaying.toggle()
                }
            }
        }
    }
}
