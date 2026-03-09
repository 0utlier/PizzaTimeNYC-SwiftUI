//
//  ContentView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/10/26.
//

import SwiftUI
import AudioToolbox

struct ContentView: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    @State private var randomNumber = 0 // background color
    @State var movePizza: PizzaPage?
    let movePizzaDuration: Double = 0.5
    
    let colorBackGround: [Color] = [
        .ptnColorYellow,
        .blue, // don't hide buttons that are ptnColorBlue
        .ptnColorGreen,
        .ptnColorOrange,
        .ptnColorRedRating
    ]
    
    var body: some View {
        NavigationView { // Use NavigationView
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                //                NavigationLink(destination: ListPage(), tag: .list, selection: $nav.activePage) {EmptyView()}
                //                NavigationLink(destination: ListPage(), tag: .map, selection: $nav.activePage) {EmptyView()}
                //                NavigationLink(destination: ListPage(), tag: .closest, selection: $nav.activePage) {EmptyView()}
                //                NavigationLink(destination: AboutPage(), tag: .about, selection: $nav.activePage) {EmptyView()}
                //                NavigationLink(destination: AddPage(), tag: .add, selection: $nav.activePage) {EmptyView()}
                //                NavigationLink(destination: FeedbackPage(), tag: .feedback, selection: $nav.activePage) {EmptyView()}
                NavigationLink(
                    destination: nav.activePage?.destinationView,
                    isActive: Binding(
                        get: { nav.activePage != nil },
                        set: { if !$0 { nav.activePage = nil } }
                    )
                ) {
                    EmptyView()
                }
                
                ZStack(alignment: .topTrailing) {
                    // TODO: set background to change when page is reloaded
                    colorBackGround[randomNumber]
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
                            
                            Image("MCQpizzaTimeLOGO")
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
                            if musicState.isPlaying {
                                GIFView(name: "dancingPizzaAlpha")
                                    .frame(width: screenWidth / 2)
                                    .padding(EdgeInsets(top: -183, leading: 0, bottom: 0, trailing: 0))
                            }
                            else {
                                Image("sadPizzaWalpha")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2)
                                    .padding(
                                        EdgeInsets(top: -150, leading: 0, bottom: 100, trailing: 0)
                                    )
                            }
                        }
                        
                        
                        HStack(spacing: -screenWidth/5) { // Pizza Buttons TOP
                            Button {
                                let page: PizzaPage = .list
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceLEFTt")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.blue)
                                    .offset(x: movePizza == .list ? -70 : 0, y: movePizza == .list ? -50 : -2)
                            }
                            .contentShape(TriangleLeft()
                                .rotation(.degrees(180)))
                            Button {
                                let page: PizzaPage = .map
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceTOP")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.green)
                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: 20, trailing: 0))
                                    .offset(x: -1, y: movePizza == .map ? -200 : -2)
                            }
                            .contentShape(TriangleMiddle()
                                .rotation(.degrees(180)))
                            
                            Button {
                                let page: PizzaPage = .closest
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceRIGHTt")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.red)
                                    .offset(x: movePizza == .closest ? 70 :-3, y: movePizza == .closest ? -50 : 0)
                            }
                            .contentShape(TriangleLeft()
                                .rotation(.degrees(180)))
                            
                            
                        }// END HStack PiBu top 3
                        
                        HStack(spacing: -screenWidth/5) { // Pizza Buttons BOTTOM
                            Button {
                                let page: PizzaPage = .feedback
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceLEFTb")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.blue)
                                    .offset(x: movePizza == .feedback ? -70 : 0, y: movePizza == .feedback ? 50 : 0)
                            }
                            .contentShape(TriangleLeft())
                            //                            .rotation(.degrees(90)))
                            
                            Button {
                                let page: PizzaPage = .add
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceBOTTOM")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.green)
                                    .padding(EdgeInsets (top: 0, leading: 0, bottom: -18, trailing: 0))
                                    .offset(y: movePizza == .add ? screenHeight/2 : 0)
                            }
                            .contentShape(TriangleMiddle()
                                .rotation(.degrees(0)))
                            
                            Button {
                                let page: PizzaPage = .about
                                withAnimation(.easeInOut(duration: movePizzaDuration)) {
                                    movePizza = page
                                    playAudioSoundForPage(page.audioFileName)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + movePizzaDuration) {
                                    nav.lastPage = nav.activePage
                                    nav.activePage = page
                                }
                            }
                            label: {
                                Image("MCQSliceRIGHTb")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth / 2.5)
                                //                                .border(Color.red)
                                    .offset(x: movePizza == .about ? 70 : -3, y: movePizza == .about ? 50 : 1)
                            }
                            .contentShape(TriangleRight()
                                .rotation(.degrees(180)))
                            
                        }// END HStack PiBu top 3
                        .padding()
                    } // END VStack PMan Logo Butt
                } // END ZStack
                .onDisappear {
                    movePizza = nil
                    randomNumber = (randomNumber + 1) % colorBackGround.count
                    print("left options page \(randomNumber)")
                }
            } // END View
        }
        .navigationBarBackButtonHidden(true)
    }
    // FUNCTIONS for page (maybe move to separate page)
    func soundButton() {
        musicState.isPlaying.toggle()
        print("Music is \(musicState.isPlaying ? "on" : "off")")
    }
    func playAudioSoundForPage(_ audioFileName: String) {
        
        var soundIdRing:SystemSoundID = 0
        let soundUrl = Bundle.main.path(forResource: audioFileName, ofType: "m4a")
        print("Playing sound \(audioFileName)")
        let nsurl = NSURL.fileURL(withPath: soundUrl!)
        AudioServicesCreateSystemSoundID(nsurl as CFURL, &soundIdRing)
        AudioServicesPlaySystemSound(soundIdRing)
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
        .environmentObject(NavigationManager())
}
