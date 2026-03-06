//
//  GIFView.swift
//  PizzaTimeNYCII
//
//  Created by ASTROID on 2/12/26.
//

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
