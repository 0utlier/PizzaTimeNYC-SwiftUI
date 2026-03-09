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
                    //                    HStack { // volume button
                    Spacer()
                    Button(action: backButton) {
                        Image("MCQppiBACK")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    //                    } // END HStack
                    
                    //                    ZStack {
                    
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
                    
                    // TODO: add in dancing GIF
                    //                                                let pizzaDancingMan = UIImage.animatedImageNamed("KenPizzaMan", duration: 5)
                    //                            let frames = pizzaDancingMan?.images
                    GIFView(name: "dancingPizzaAlpha")
                    //                        .frame(width: 10, height: 10)
                                            .aspectRatio(contentMode: .fill)
                    //                        .frame(width: screenWidth / 6, height: screenHeight / 6)
                    //                        .scaledToFit()
                    //                        .padding()
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
        .navigationBarBackButtonHidden(true)
    }
    func backButton() {
        // navigate to last page
        print("back button pressed")
        nav.activePage = nav.lastPage
    }
}
#Preview {
    AboutPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
