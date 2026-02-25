//
//  FeedbackPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/21/26.
//


import SwiftUI

struct FeedbackPage: View {
    @EnvironmentObject var musicState: MusicState
    enum FeedbackType: String, CaseIterable, Identifiable {
        case positive, error, request
        var id: Self { self }
    }
    @State private var feedbackSelected: FeedbackType = .positive
    @State private var userFeedback: String = ""
    //    @FocusState private var userFeedbackFieldIsFocused: Bool = false
    @State private var emailOptional: String = ""
    //    @FocusState private var emailFieldIsFocused: Bool = false
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.yellow
                    .ignoresSafeArea()
                
                VStack { // back button, Logo, selection, text box x2, submit
                    Button(action: backButton) {
                        Image("MCQppiBACK")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth / 6)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Image("PTM_Title")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth  / 2)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: screenWidth / 10,
                                bottom: 30,
                                trailing: screenWidth / 10
                            )
                        )
                    Picker("Type", selection: $feedbackSelected) {
                        ForEach(FeedbackType.allCases) { feedBack in
                            Text(feedBack.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .accentColor(.red)
                    .frame(width: screenWidth / 1.25)
                    
                    ZStack(alignment: .topLeading) {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.orange.opacity(0.5))
                        
                        TextEditor(text: $userFeedback)
                            .frame(width: screenWidth / 1.25, height: screenHeight / 3)
                            .colorMultiply(.orange.opacity(0.4))
                            .padding()
                        
                        if userFeedback.isEmpty {
                            Text("Send constructive and productive feedback!")
                                .frame(width: screenWidth / 1.25, height: screenHeight / 3)
                                .foregroundStyle(.gray)
                                .opacity(userFeedback.isEmpty ? 1 : 0)
                                .padding()
                                .foregroundColor(.gray)
//                                .allowsHitTesting(false) // lets click go through
                        }
                    } // END ZStack
                                        
                    // Optional email field
                    TextField(text: $emailOptional, prompt: Text("Email (optional)")) {
                        Text("Username")
                            .background(Color.red)
                        
                    }
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .textFieldStyle(.plain)
                    .frame(width: screenWidth / 1.25)
                    .background(Color.orange.opacity(0.4))
                    .padding()
                    .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    Button(action: backButton) {
                        Text("SUBMIT")
                            .foregroundColor(.red)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    
                    
                    // Version number at bottom
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        Text("Version 1.0")
                            .foregroundColor(.red)
                        //                    .font(.caption)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        //                            .ignoresSafeArea()
                    }
                } // VSTACK END
            }
        }
    }
    func backButton() {
        print("back button pressed")
    }
}
#Preview {
    FeedbackPage()
        .environmentObject(MusicState())
}
