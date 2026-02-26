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
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            //            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.yellow
                    .ignoresSafeArea()
                
                VStack { // back button, Logo, selection, text box x2, submit
                    HStack(spacing: screenWidth / 5) {
                        Button(action: searchButton) {
                            Image("MCQMapSEARCH")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: listButton) {
                            Image("MCQMapOPTIONS")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: soundButton) {
                            Image(
                                musicState.isPlaying ? "MCQMapSOUND" : "MCQMapSOUNDNOT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                        
                    } // END HStack buttons
                    
                    
                    ZStack(alignment: .leading) {
                        Color.green
//                            .ignoresSafeArea()
                        
                        List(pizzaPlaces, id: \.id) { PizzaPlace in
                            
                            PPListViewItem(pizzaPlace: PizzaPlace)
//                                .frame(width: screenWidth)
                                .listRowBackground(Color.orange.opacity(0.9))
                                .listRowSeparatorTint(.red)
                        }
                        .listStyle(PlainListStyle())
//                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        //                    .background(Color.blue)
//                        .colorMultiply(.yellow)
//                        .listRowBackground(Color.red)
//                                              .padding(.trailing, 5)
//                                              .padding(.leading, 5)
//                                              .padding(.top, 2)
//                                              .padding(.bottom, 2)
                        
                        .frame(width: screenWidth, alignment: .leading)
                        //                    .refreshable {
                        //                                 await listButton()
                        //                             }
                    }
//                    Spacer()
                    HStack/*(alignment: .bottom)*/ {
                        Button(action: mapButton) {
                            Image("MCQTabBarMAP")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                                .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: -8))
                            
                        }
                        Button(action: listButton) {
                            Image("MCQTabBarLIST")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2)
                                .padding(EdgeInsets(top: -20, leading: 0, bottom: -200, trailing: 0))
                        }
                    }// END HStack buttons
                    //                    .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -20))
                } // END VStack page
            }
            
        }
    }
    
    
    // FUNCTIONS for page (maybe move to separate page)
    func soundButton() {
        musicState.isPlaying.toggle()
        print("Music is \(musicState.isPlaying ? "on" : "off")")
    }
    func mapButton() {
        // TODO: navigate to map page
        print("back to the map!")
    }
    func listButton() {
        // TODO: navigate to list page
        print("back to the list!")
    }
    func searchButton() {
        // TODO: navigate to contentview page
        print("back button pressed")
    }
}
#Preview {
    ListPage()
        .environmentObject(MusicState())
}
