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
/*import SwiftUI
import ImageIO
import UIKit

struct GIFView: View {

    let frames: [UIImage]
    let frameDurations: [Double]

    @State private var currentFrameIndex = 0

    init(name: String) {
        var images: [UIImage] = []
        var durations: [Double] = []

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
                playGIF()
            }
    }

    private func playGIF() {
        guard !frames.isEmpty else { return }

        // Start on first frame
        currentFrameIndex = 0

        func scheduleNextFrame() {
            let delay = frameDurations[currentFrameIndex]
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                currentFrameIndex = (currentFrameIndex + 1) % frames.count
                scheduleNextFrame()
            }
        }

        scheduleNextFrame()
    }
}*/

/* //WORKING
 import SwiftUI
import UIKit
import ImageIO

struct GIFView: UIViewRepresentable {

    let name: String

    func makeUIView(context: Context) -> UIImageView {

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = loadGIF(name)

        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}

    private func loadGIF(_ name: String) -> UIImage? {

        guard let url = Bundle.main.url(forResource: name, withExtension: "gif"),
              let data = try? Data(contentsOf: url),
              let source = CGImageSourceCreateWithData(data as CFData, nil)
        else { return nil }

        var images: [UIImage] = []
        var duration: Double = 0

        let count = CGImageSourceGetCount(source)

        for i in 0..<count {

            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }

            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as? [CFString: Any],
               let gifInfo = properties[kCGImagePropertyGIFDictionary] as? [CFString: Any],
               let delay = gifInfo[kCGImagePropertyGIFDelayTime] as? Double {
                duration += delay
            }
        }

        return UIImage.animatedImage(with: images, duration: duration)
    }
}*/

/*
 import SwiftUI
 import WebKit

 struct GIFView: UIViewRepresentable {
     private let gifName: String
     
     init(_ gifName: String) {
         self.gifName = gifName
     }
     func makeUIView(context: Context) -> WKWebView {
         let webView = WKWebView()
         let url = Bundle.main.url(forResource: gifName, withExtension: "gif")!
         let data = try! Data(contentsOf: url)
         
         webView.load(
             data,
             mimeType: "image/gif",
             characterEncodingName: "UTF-8",
             baseURL: url.deletingLastPathComponent()
         )
         return webView
     }
     
     func updateUIView(_ uiView: WKWebView, context: Context) {
         uiView.reload()
     }
     
 }
 struct GifImage_Preview: PreviewProvider {
     static var previews: some View {
         GIFView("KenPizzaMan")
     }
 }
*/
