//
//  MapPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/10/26.
//

import SwiftUI
import MapKit

struct MapPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    
    @StateObject private var locationManager = LocationManager()
    @State private var centerTrigger = false
    @State private var droppedCoordinate: CLLocationCoordinate2D? = nil
    
    var showingPrompt: Bool { droppedCoordinate != nil }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack {
                // MARK: Map — fills entire screen
                ZStack(alignment: .bottomLeading) {
                    PizzaMapView(
                        centerTrigger: $centerTrigger,
                        droppedCoordinate: $droppedCoordinate,
                        locationManager: locationManager,
                        pizzaPlaces: pizzaPlaces
                    )
                    .ignoresSafeArea()
                    
                    Button(action: {
                        print("find me!")
                        centerTrigger = true
                    }) {
                        Image("MCQMapLOCATION")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenHeight / 20)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 30, trailing: 0))
                }
                
                // MARK: Buttons floating over map
                VStack {
                    HStack(spacing: screenWidth / 5) {
                        Button(action: searchButton) {
                            Image("MCQMapSEARCH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        
                        Button(action: nav.goHome) {
                            Image("MCQMapOPTIONS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        
                        Button(action: musicState.soundButton) {
                            Image(musicState.isPlaying ? "MCQMapSOUND" : "MCQMapSOUNDNOT")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button(action: nav.mapButton) {
                            Image("MCQTabBarMAP")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                        }
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: -8))
                        
                        Button(action: nav.listButton) {
                            Image("MCQTabBarLIST")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                        }
                        .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: 0))
                    }
                }
                
                // MARK: New Place Prompt
                if showingPrompt {
                    NewPlacePrompt(
                        onAddNew: {
                            print("ADD NEW selected at \(droppedCoordinate!.latitude), \(droppedCoordinate!.longitude)")
                            droppedCoordinate = nil
                        },
                        onSetCurrent: {
                            print("Set as my Current Location selected at \(droppedCoordinate!.latitude), \(droppedCoordinate!.longitude)")
                            droppedCoordinate = nil
                        },
                        onCancel: {
                            print("Cancel selected")
                            droppedCoordinate = nil
                        }
                    )
                    .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Functions
    func searchButton()  { print("search button pressed") }
}

#Preview {
    MapPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
