//
//  WebView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/2.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let url: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: URL(string: url)!)
        uiView.load(req)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.apple.com")
    }
}
