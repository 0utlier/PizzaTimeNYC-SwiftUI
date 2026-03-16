//
//  CameraView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 3/8/26.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var camera = CameraManager()
    @Environment(\.dismiss) var dismiss
    @State private var zoomFactor: CGFloat = 1.0
    
    var onImageCaptured: (UIImage) -> Void
    var body: some View {
        
        ZStack {
            CameraPreview(session: camera.session)
                .ignoresSafeArea()
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            zoomFactor = value
                            camera.setZoom(value)
                        })
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                Spacer()
                
                VStack {
                    Slider(
                        value: Binding(
                            get: { Double(zoomFactor) },
                            set: {
                                zoomFactor = CGFloat($0)
                                camera.setZoom(CGFloat($0))
                            }),
                        in: 1...5
                    )
                    .padding(.horizontal)
                    
                    Button {
                        camera.takePhoto()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 6)
                                .frame(width: 80, height: 80)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 65, height: 65)
                        }
                    }
                    .padding(.top, 20)
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            camera.start()
            camera.onPhotoCaptured = { image in
                onImageCaptured(image)
                dismiss()
            }
        }
        .onDisappear {
            camera.stop()
        }
    }
}
