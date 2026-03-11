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
    var pizzaPlace: PizzaPlace?
    
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
                        Button(action: nav.backButton) {
                            Image("MCQppiBACK")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: nav.listButton) {
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
                    
                    Button(action: nav.directionsButton) {
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
}

#Preview {
    PPPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
