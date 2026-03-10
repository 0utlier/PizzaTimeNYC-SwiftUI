//
//  AboutPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/16/26.
//

import SwiftUI

struct AboutPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(/*.ignoresSafeArea()*/) {
                Color.ptnColorYellow
                    .ignoresSafeArea()
                
                VStack(spacing: 0) { // pizza man, Logo, Buttons
                    Spacer()
                    Button(action: nav.backButton) {
                        Image("MCQppiBACK")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Image("MCQpizzaTimeLOGO")
                        .resizable()
                        .scaledToFit()
                        .padding(
                            EdgeInsets(
                                top: screenHeight / 10,
                                leading: screenWidth / 10,
                                bottom: 0,
                                trailing: screenWidth / 10
                            )
                        )
                    Text("BROUGHT TO YOU BY OUTLIER")
                        .foregroundColor(Color.ptnColorRed)
                        .font(Font.custom("Rubik-Black", size: 25))
                    
                        .font(.title2.bold())
                    
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    GIFView(name: "DancingPizzaAlpha")
                        .aspectRatio(contentMode: .fill)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 160, trailing: 0))
                    
                    VStack {
                        HStack {
                            Text("DESIGN")
                                .foregroundColor(Color.ptnColorRed)
                                .font(Font.custom("Rubik-Black", size: 25))
                            
                            Text("Rachel McHugh")
                                .foregroundColor(Color.ptnColorBlue)
                                .font(Font.custom("Rubik-Light", size: 25))
                        }
                        HStack {
                            Text("ARTWORK")
                                .foregroundColor(Color.ptnColorRed)
                                .font(Font.custom("Rubik-Black", size: 25))
                            
                            Text("Ken Siu")
                                .foregroundColor(Color.ptnColorBlue)
                                .font(Font.custom("Rubik-Light", size: 25))
                        }
                        HStack {
                            Text("PROGRAMMATION")
                                .foregroundColor(Color.ptnColorRed)
                                .font(Font.custom("Rubik-Black", size: 25))
                            
                            Text("JD Leonard")
                                .foregroundColor(Color.ptnColorBlue)
                                .font(Font.custom("Rubik-Light", size: 25))
                        }
                    } // END VSTACK: names
                    .padding(EdgeInsets(top: -160, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }
        .navigationBarBackButtonHidden(true) // Hide built in Navigation button
    }
}
#Preview {
    AboutPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
