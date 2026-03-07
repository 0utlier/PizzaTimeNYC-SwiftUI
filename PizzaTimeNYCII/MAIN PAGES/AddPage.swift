//
//  AddPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/24/26.
//

import SwiftUI
//import PhotosUI

struct AddPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    @State private var placeName = ""
    @State private var placeAddress = ""
    // Image variables
    @State private var image: Image?
//    @State private var imageIsSubmitted = false
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.ptnColorYellow
                    .ignoresSafeArea()
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
                VStack { // back button, Logo, selection, text box x2, submit
                    HStack(spacing: screenWidth / 5) {
                        Button(action: backButton) {
                            Image("MCQppiBACK")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 6)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        
                        Button(action: nav.goHome) { // TODO: does the info retain?
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
                        //                            Text("Username")
                        //                            .background(Color.red)
                    }
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //                    .textFieldStyle(.plain)
                    .frame(width: screenWidth / 1.25, height: screenHeight / 20)
                    .background(Color.ptnColorOrange)
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
                        TextField(text: $placeAddress, prompt: Text(" PP ADDRESS")) {}
                            .frame(width: screenWidth / 1.25, height: screenHeight / 20)
                            .background(Color.ptnColorOrange)
                            .padding()
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                    }
                    
                    Text("TAKE A PICTURE")
                    
                    Button(action: cameraButton) {
                        image?
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 2.25)
                        if image == nil {
                            Image("pizzaCamera2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth / 2.25)
                        }
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
        .navigationBarBackButtonHidden(true)
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    // FUNCTIONS for page (maybe move to separate page)
    func soundButton() {
        musicState.isPlaying.toggle()
        print("Music is \(musicState.isPlaying ? "on" : "off")")
    }
    func optionsButton() {
        // navigate to options
        print("back to all of the options!")
        nav.goHome()
    }
    func backButton() {
        // navigate to last page
        print("back button pressed")
        nav.activePage = nav.lastPage
    }
    func cameraButton() {
        showingImagePicker = true
        // TODO: open camera to take picture [change bool if picture is taken]
//        imageIsSubmitted.toggle()
        print("camera button pressed - camera or picker?")
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
        if image == nil {
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
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    AddPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
