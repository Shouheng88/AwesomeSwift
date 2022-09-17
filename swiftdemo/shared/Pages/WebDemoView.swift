//
//  WebDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/17.
//

import SwiftUI
import WebKit

struct WebDemoView: UIViewRepresentable {

//    func makeUIView(context: Context) -> WKWebView {
//        return WKWebView()
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        let req = URLRequest(url: URL(string: "https://www.baidu.com")!)
//        uiView.load(req)
//    }
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let req = URLRequest(url: URL(string: "https://www.apple.com")!)
        uiView.load(req)
    }
}

struct WebDemoView_Previews: PreviewProvider {
    static var previews: some View {
        WebDemoView()
    }
}
