//
//  AddPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/24/26.
//

import SwiftUI

struct AddPage: View {
    @EnvironmentObject var musicState: MusicState
    @State private var placeName = ""
    @State private var placeAddress = ""
    @State private var pictureTaken = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let screenWidth = geometry.size.width
                let screenHeight = geometry.size.height
                
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
                        
                        Text("NAME OF PIZZA PLACE")
                            .multilineTextAlignment(.trailing)
                        //                        .font(.largeTitle)
                            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                        TextField(text: $placeName, prompt: Text(" PP NAME")) {
                            Text("Username")
                            //                            .background(Color.red)
                        }
                        //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                    .textFieldStyle(.plain)
                        .frame(width: screenWidth / 1.25, height: screenHeight / 20)
                        .background(Color.orange.opacity(0.4))
                        .padding()
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        
                        Text("ADDRESS")
                        
                        ZStack(alignment: .leading) {
                            Button(action: findLocationAddress) {
                                Image("MCQMapLOCATION")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenHeight / 20)
                            }
                            .padding(EdgeInsets(top: 0, leading: -30, bottom: 0, trailing: 0))
                            .ignoresSafeArea()
                            //                        Spacer()
                            TextField(text: $placeAddress, prompt: Text(" PP ADDRESS")) {
                                Text("Username")
                                //                                .background(Color.red)
                                
                            }
                            //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            //                    .textFieldStyle(.plain)
                            .frame(width: screenWidth / 1.25, height: screenHeight / 20)
                            .background(Color.orange.opacity(0.4))
                            .padding()
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        }
                        
                        Text("TAKE A PICTURE")
                        
                        Button(action: cameraButton) {
                            Image(pictureTaken ? "pizzaCamera" : "pizzaCamera2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.25)
                        }
                        
                        Button(action: addButton) {
                            Image("MCQaddADD")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 1.5)
                        }
                        
                        Spacer()
                    } // VSTACK END
                }
            }
        }
    }
        // FUNCTIONS for page (maybe move to separate page)
        func soundButton() {
            musicState.isPlaying.toggle()
            print("Music is \(musicState.isPlaying ? "on" : "off")")
        }
        func listButton() {
            // TODO: navigate to list page
            print("back to the list!")
        }
        func backButton() {
            // TODO: navigate to contentview page
            print("back button pressed")
        }
        func cameraButton() {
            // TODO: open camera to take picture [change bool if picture is taken]
            pictureTaken.toggle()
            print("camera button pressed - \(pictureTaken)")
        }
        func addButton() {
            if placeName.isEmpty {
                // TODO: warn user
                print("Please enter a name!")
            }
            if placeAddress.isEmpty {
                // TODO: warn user
                print("Please enter an address!")
            }
            if !pictureTaken {
                // TODO: warn user
                print("Is there a picture?")
            }
            print("add button pressed for \(placeName) found at \(placeAddress)")
        }
        func findLocationAddress() {
            // TODO: find location address
            placeAddress = "ADDRESS FOUND!"
            print("found the address: \(placeAddress)")
        }
    }

#Preview {
    AddPage()
        .environmentObject(MusicState())
}
