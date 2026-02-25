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
                    //                    HStack { // volume button
                    //                    Spacer()
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
                    
//                    ZStack(alignment: .topLeading) {
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.orange.opacity(0.5))
                        
                        TextEditor(text: .constant("Send constructive and productive feedback!"))
                            .frame(width: screenWidth / 1.25, height: screenHeight / 3)
                        //                        .foregroundColor(Color.black)
//                                                .background(.red)
                            .colorMultiply(.orange.opacity(0.4))
//                            .background(RoundedRectangle(cornerRadius: 8)
//                                .fill(Color.orange.opacity(0.4)))
                            .padding()
                        
//                        if !userFeedback.isEmpty {
//                            Text("Send constructive and productive feedback!")
//                                .foregroundColor(.gray)
//                                .padding(.horizontal, 14)
//                                .padding(.vertical, 12)
//                                .allowsHitTesting(false) // lets click go through
//                        }
//                    }
                    
//                    TextField(text: $userFeedback, prompt: Text("Send constructive and productive feedback!")) {
//                        Text("Username")
//                    }
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .frame(height: screenHeight / 3)
//                    .background(RoundedRectangle(cornerRadius: 8)
//                        .fill(Color.orange.opacity(0.4)))
//                    .padding()
                    
                    // Optional email field
                    TextField(text: $userFeedback, prompt: Text("Email (optional)")) {
                        Text("Username")
                        //                            .background(Color.red)
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    Button(action: backButton) {
                        Text("SUBMIT")
                            .foregroundColor(.red)
                        //                            .font(.headline)
                            .font(.system(size: 20, weight: .bold, design: .default))
                    }
                    
                    
                    //                    TextField(
                    //                           "Send constructive and productive feedback!",
                    //                           text: $userFeedback
                    //                       )
                    //                       .focused($userFeedbackFieldIsFocused)
                    //                       .onSubmit {
                    //                           validate(name: userFeedback)
                    //                       }
                    //                       .textInputAutocapitalization(.never)
                    ////                       .disableAutocorrection(true)
                    //                       .border(.secondary)
                    
                    //                       Text(userFeedback)
                    //                           .foregroundColor(userFeedbackFieldIsFocused ? .red : .blue)
                    //                   }
                    
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
