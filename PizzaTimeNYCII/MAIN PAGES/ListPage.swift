//
//  ListPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/25/26.
//

/*https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation*/

import SwiftUI

struct ListPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            //            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.ptnColorYellow
                    .ignoresSafeArea()
                
                VStack { // back button, Logo, selection
                    HStack(spacing: screenWidth / 5) {
                        Button(action: searchButton) {
                            Image("MCQMapSEARCH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: nav.goHome) {
                            Image("MCQMapOPTIONS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: musicState.soundButton) {
                            Image(
                                musicState.isPlaying ? "MCQMapSOUND" : "MCQMapSOUNDNOT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    } // END HStack buttons
                    
                    ZStack(alignment: .leading) { // List
                        Color.green // behind the list
                        
                        
                        
                        
                        RefreshableScrollView {
                            await reloadList()
                        } content: {
                            LazyVStack(spacing: 0) {
                                ForEach(pizzaPlaces, id: \.id) { pizzaPlace in
                                    PPListViewItem(pizzaPlace: pizzaPlace)
                                        .frame(width: screenWidth, alignment: .leading)
                                        .background(Color.ptnColorYellow)                // replaces .listRowBackground
                                    // Purple separator — replaces .listRowSeparatorTint(.purple)
                                    // You don't want one after the very last row, so we check the index
                                    if pizzaPlace.id != pizzaPlaces.last?.id { // prevents an orphan separator dangling below the final row
                                        Divider()
                                            .overlay(Color.purple)           // tints the 1pt line purple
                                            .padding(.leading, 0)            // full-width, matching PlainListStyle
                                    }
                                }
                            }
                        }
                        
                        //                        List(pizzaPlaces, id: \.id) { PizzaPlace in
                        //
                        //                            PPListViewItem(pizzaPlace: PizzaPlace)
                        //                                .listRowBackground(Color.ptnColorYellow)
                        //                                .listRowSeparatorTint(.purple)
                        //                        }
                        //                        .listStyle(PlainListStyle())
                        //                        //                        .colorMultiply(.ptnColorYellow)
                        //
                        //                        .frame(width: screenWidth, alignment: .leading)
                        //                        // TODO: refresh with pizza dollar
                        //                        .refreshable {
                        //                            await reloadList()
                        //                        }
                        
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                    }
                    
                    
                    
                    
                    
                    
                    
                    HStack/*(alignment: .bottom)*/ { // Buttons
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
                    }// END HStack buttons
                } // END VStack page
            } // END ZStack all
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    // FUNCTIONS for page (maybe move to separate page)
    func reloadList() {
        // TODO: check for updated places, refresh current location, sort for closest
        print("reloading list!")
    }
    func searchButton() {
        // TODO: populate a search view
        print("search button pressed")
    }
}
#Preview {
    ListPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
