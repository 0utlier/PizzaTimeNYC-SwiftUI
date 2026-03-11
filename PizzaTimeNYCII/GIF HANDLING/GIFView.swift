//
//  GIFView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/12/26.
//


import SwiftUI
import ImageIO
import UIKit

struct GIFView: View {
    
    let frames: [UIImage]
    let frameDurations: [Double]
    
    @State private var currentFrameIndex = 0
    @State private var isPlaying = false
    @State private var animationTask: Task<Void, Never>? = nil
    
    init(name: String) {
        var images: [UIImage] = []
        var durations: [Double] = []
        print("Loading GIF for Orientation: \(UIDevice.current.orientation)")
        if let url = Bundle.main.url(forResource: name, withExtension: "gif"),
           let data = try? Data(contentsOf: url),
           let source = CGImageSourceCreateWithData(data as CFData, nil) {
            
            let count = CGImageSourceGetCount(source)
            
            for i in 0..<count {
                if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    images.append(UIImage(cgImage: cgImage))
                }
                
                if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any],
                   let gifInfo = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any],
                   let delay = gifInfo[kCGImagePropertyGIFDelayTime] as? Double {
                    durations.append(delay)
                } else {
                    durations.append(0.1)
                }
            }
        }
        
        self.frames = images
        self.frameDurations = durations
    }
    
    var body: some View {
        Image(uiImage: frames.isEmpty ? UIImage() : frames[currentFrameIndex])
            .resizable()
            .scaledToFit()
            .onAppear {
                startAnimation()
            }
            .onDisappear {
                stopAnimation()
            }
    }
    
    private func startAnimation() {
        guard !frames.isEmpty else { return }
        guard !isPlaying else { return }
        
        isPlaying = true
        
        // Use async Task to loop properly
        animationTask = Task {
            while isPlaying && !frames.isEmpty {
                let delay = frameDurations[currentFrameIndex]
                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                currentFrameIndex = (currentFrameIndex + 1) % frames.count
            }
        }
    }
    
    private func stopAnimation() {
        isPlaying = false
        animationTask?.cancel()
        animationTask = nil
    }
}
