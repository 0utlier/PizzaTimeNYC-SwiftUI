//
//  PPPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/26/26.
//

import SwiftUI

struct PPPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    @State private var placeName = ""
    @State private var placeAddress = ""
    @State private var pictureTaken = false
    
    var body: some View {
        //        NavigationView {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            //                let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.yellow
                    .ignoresSafeArea()
                
                VStack { // back button, Logo, selection, text box x2, submit
                    HStack(spacing: screenWidth / 5) {
                        Button(action: backButton) {
                            Image("MCQppiBACK")
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
                    
                    Image("TwoBrosPizzaLogo")
                        .resizable()
                        .scaledToFit()
                    PPPageViewItem(pizzaPlace: pizzaPlaces[0])
                    //                        Text("NAME OF PIZZA PLACE")
                    //                            .frame(maxWidth: screenWidth / 4, alignment: .leading)
                    //                            .font(.largeTitle)
                    //                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                    //                        Text("ADDRESS")
                    //                            .frame(maxWidth: .infinity, alignment: .leading)                                                    .multilineTextAlignment(.trailing)
                    //                                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    Button(action: goButton) {
                        Image("MCQppiGO")
                        //                                .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 2)
                        //                                .padding(EdgeInsets(top: 0, leading: 0, bottom: -10, trailing: 0))
                    }
                    
                } // VSTACK END
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    //    }
    // FUNCTIONS for page (maybe move to separate page)
    func soundButton() {
        musicState.isPlaying.toggle()
        print("Music is \(musicState.isPlaying ? "on" : "off")")
    }
    func listButton() {
        // navigate to list page
        print("back to the list!")
        nav.lastPage = nav.activePage
        nav.activePage = .list
    }
    func backButton() {
        // navigate to last page
        print("back button pressed")
        nav.activePage = nav.lastPage
    }
    func goButton() {
        // TODO: send to map page with current pizza place
        print("Please enter a name!")
    }
}

#Preview {
    PPPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
