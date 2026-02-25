//
//  AboutPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/16/26.
//

import SwiftUI

struct AboutPage: View {
    @EnvironmentObject var musicState: MusicState
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(/*.ignoresSafeArea()*/) {
                Color.yellow
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
                    
                    Image("PTM_Title")
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
                        .font(.title2.bold())
                    
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    // TODO: add in dancing GIF
                    //                                                let pizzaDancingMan = UIImage.animatedImageNamed("KenPizzaMan", duration: 5)
                    //                            let frames = pizzaDancingMan?.images
                    GIFView("KenPizzaMan")
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 160, trailing: 0))
                                        
                    VStack {
                        let attributedString = try! AttributedString(
                            markdown: "_DESIGN_ Rachel McHugh"
                        )
                        Text(attributedString)
//                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Text("ARTWORK Ken Siu")
                        //                            .font(.title3.bold())
//                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Text("PROGRAMMATION JD Leonard")
                        //                            .font(.title3.bold())
//                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .font(.title3.bold())
                    .padding(EdgeInsets(top: -160, leading: 0, bottom: 0, trailing: 0))
                    // END VSTACK: names
                    //                        Image(musicState.isPlaying ? "sadPizzaWalpha" : "sadPizzaWalpha")
                    //                            .resizable()
                    //                            .scaledToFit()
                    //                            .frame(width: screenWidth / 2)
                    //                            .padding(
                    //                                EdgeInsets(top: -150, leading: 0, bottom: 100, trailing: 0)
                    
                    
                    
                    
                }
            }
        }
    }
    func backButton() {
        print("back button pressed")
    }
}
#Preview {
    AboutPage()
        .environmentObject(MusicState())
}
