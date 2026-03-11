//
//  FeedbackPage.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/21/26.
//


import SwiftUI

struct FeedbackPage: View {
    @EnvironmentObject var musicState: MusicState
    @EnvironmentObject var nav: NavigationManager
    enum FeedbackType: String, CaseIterable, Identifiable {
        case positive, error, request
        var id: Self { self }
    }
    @State private var feedbackSelected: FeedbackType = .positive
    @State private var userFeedback: String = ""
    @State private var emailOptional: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            ZStack(alignment: .center) {
                Color.ptnColorYellow
                    .ignoresSafeArea()
                
                VStack { // back button, Logo, selection, text box x2, submit
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
                        .frame(width: screenWidth  / 2)
                        .padding(
                            EdgeInsets(
                                top: 0,
                                leading: screenWidth / 10,
                                bottom: 30,
                                trailing: screenWidth / 10
                            )
                        )
                    CustomSegmentedPicker(selection: $feedbackSelected, cases: Array(FeedbackType.allCases))
                        .frame(width: screenWidth / 1.25)
                    //                    Picker("Type", selection: $feedbackSelected) {
                    //                        ForEach(FeedbackType.allCases) { feedBack in
                    //                            Text(feedBack.rawValue.capitalized)
                    //
                    //                        }
                    //                    }
                    //                    .pickerStyle(SegmentedPickerStyle())
                    ////                    .accentColor(.green)
                    //                    .frame(width: screenWidth / 1.25)
                    
                    ZStack(alignment: .topLeading) {
                        //                        RoundedRectangle(cornerRadius: 8)
                        //                            .fill(Color.orange.opacity(0.5))
                        
                        TextEditor(text: $userFeedback)
                            .frame(width: screenWidth / 1.25, height: screenHeight / 3)
                            .colorMultiply(.ptnColorOrange)
                            .padding()
                        
                        if userFeedback.isEmpty {
                            Text("Send constructive and productive feedback!")
                                .foregroundColor(.ptnColorRed)
                                .font(Font.custom("Rubik", size: 20))
                                .frame(width: screenWidth / 1.25, height: screenHeight / 3, alignment: .top)
                                .opacity(userFeedback.isEmpty ? 1 : 0)
                                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                                .allowsHitTesting(false) // lets click go through
                        }
                    } // END ZStack
                    
                    // Optional email field
                    TextField(text: $emailOptional, prompt: Text(" Email (optional)")
                        .foregroundColor(.ptnColorRed)
                        .font(Font.custom("Rubik", size: 20))) {
                            Text("Username")
                                .background(Color.red)
                            
                        }
                    //                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    //                    .textFieldStyle(.plain)
                        .frame(width: screenWidth / 1.25)
                        .background(.ptnColorOrange)
                    //                        .padding()
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    
                    Button(action: submitButton) {
                        Text("SUBMIT")
                            .foregroundColor(Color.ptnColorRed)
                            .font(Font.custom("Rubik-Bold", size: 20))
                    }
                    
                    
                    // Version number at bottom
                    Spacer()
                    HStack(alignment: .bottom) {
                        Spacer()
                        Text("Version 1.0")
                            .foregroundColor(Color.ptnColorRed)
                            .font(Font.custom("Rubik-Light", size: 20))
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                        //                            .ignoresSafeArea()
                    }
                } // VSTACK END
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func submitButton() {
        if userFeedback.isEmpty {
            // TODO: pop up warning [Edit / Home Page]
            print("You didn't say anything?")
        }
        print("\(emailOptional.isEmpty ? "User" : "'\(emailOptional)'") gave feedback of type \(feedbackSelected.rawValue.capitalized):\n*\(userFeedback)*")
        // TODO: pop up note
        nav.lastPage = nav.activePage
        nav.activePage = nil
        
    }
}
#Preview {
    FeedbackPage()
        .environmentObject(MusicState())
        .environmentObject(NavigationManager())
}
