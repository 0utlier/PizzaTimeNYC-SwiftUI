//
//  ContentView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var musicState: MusicState
    @State private var movePizza: pageView?
    let movePizzaDuration: Double = 0.5
    
    enum pageView : Int {
        case home = 0
        case list = 1
        case map = 2
        case closest = 3
        case feedback = 4
        case add = 5
        case about = 6
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(alignment: .topTrailing) {
                // TODO: set background to change when page is reloaded
                Color.purple
                    .ignoresSafeArea()
                
                VStack(spacing: -40) { // pizza man, Logo, Buttons
                    HStack { // volume button
                        Spacer()
                        Button(action: soundButton) {
                            Image(
                                musicState.isPlaying ? "MCQMapSOUND" : "MCQMapSOUNDNOT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
                    } // END HStack
                    
                    ZStack {
                        // TODO: add in dancing GIF
                        //                            let pizzaDancingMan = UIImage.animatedImageNamed("KenPizzaMan", duration: 5)
                        //                            let frames = pizzaDancingMan?.images
                        //                    GIFView("KenPizzaMan")
                        
                        Image("PTM_Title")
                            .resizable()
                            .scaledToFit()
                            .padding(
                                EdgeInsets(
                                    top: screenHeight / 10,
                                    leading: screenWidth / 10,
                                    bottom: screenHeight / 10,
                                    trailing: screenWidth / 10
                                )
                            )
                        Image(musicState.isPlaying ? "sadPizzaWalpha" : "sadPizzaWalpha")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 2)
                            .padding(
                                EdgeInsets(top: -150, leading: 0, bottom: 100, trailing: 0)
                            )
                    }
                    
                    
                    HStack(spacing: -screenWidth/5) { // Pizza Buttons TOP
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .list
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.list) }
                        }
                        label: {
                            Image("Home_Button_List")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.blue)
                            //                                    .padding(EdgeInsets (top: 0, leading: 60, bottom: 0, trailing: 0))
                                .offset(x: movePizza == .list ? -70 : 0, y: movePizza == .list ? -50 : 0)
                        }
                        .contentShape(TriangleLeft()
                            .rotation(.degrees(180)))
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .map
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.map) }
                        }
                        label: {
                            Image("Home_Button_Map")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.green)
                                .padding(EdgeInsets (top: 0, leading: 0, bottom: 20, trailing: 0))
                            //                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0))
                                .offset(y: movePizza == .map ? -200 : 0)
                        }
                        .contentShape(TriangleMiddle()
                            .rotation(.degrees(180)))
                        
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .closest
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.closest) }
                        }
                        label: {
                            Image("Home_Button_Closest")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.red)
                            //                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0))
                                .offset(x: movePizza == .closest ? 70 : 0, y: movePizza == .closest ? -50 : 0)
                        }
                        .contentShape(TriangleLeft()
                            .rotation(.degrees(180)))
                        
                        
                    }// END HStack PiBu top 3
                    
                    HStack(spacing: -screenWidth/5) { // Pizza Buttons BOTTOM
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .feedback
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.feedback) }
                        }
                        label: {
                            Image("Home_Button_FB")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.blue)
                            //                                    .padding(EdgeInsets (top: 0, leading: 60, bottom: 0, trailing: 0))
                                .offset(x: movePizza == .feedback ? -70 : 0, y: movePizza == .feedback ? 50 : 0)
                        }
                        .contentShape(TriangleLeft())
                        //                            .rotation(.degrees(90)))
                        
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .add
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.add) }
                        }
                        label: {
                            Image("Home_Button_Add")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.green)
                                .padding(EdgeInsets (top: 0, leading: 0, bottom: -18, trailing: 0))
                            //                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0))
                                .offset(y: movePizza == .add ? screenHeight/2 : 0)
                        }
                        .contentShape(TriangleMiddle()
                            .rotation(.degrees(0)))
                        
                        Button {
                            withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                movePizza = .about
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                openPizzaPage(.about) }
                        }
                        label: {
                            Image("Home_Button_About")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.5)
//                                .border(Color.red)
                            //                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: 0, trailing: 0))
                                .offset(x: movePizza == .about ? 70 : 0, y: movePizza == .about ? 50 : 0)
                        }
                        .contentShape(TriangleRight()
                            .rotation(.degrees(180)))
                        
                    }// END HStack PiBu top 3
                    .padding()
                } // END VStack PMan Logo Butt
            }
            
        }
    } // END View
    
    // FUNCTIONS for page (maybe move to separate page)
    func soundButton() {
        musicState.isPlaying.toggle()
        print("Music is \(musicState.isPlaying ? "on" : "off")")
    }
    func openPizzaPage(_ page: pageView ) {
        print("opening page for \(page)")
        musicState.isPlaying.toggle()
        // TODO: open correct page
    }
}

struct TriangleLeft: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}
struct TriangleMiddle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
struct TriangleRight: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
#Preview {
    ContentView()
        .environmentObject(MusicState())
}
