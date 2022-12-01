//
//  VisionDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/30.
//

import SwiftUI

struct VisionDemoView: View {
    
    var body: some View {
        VStack {
            // 实时文字识别：16.0 以上才能使用
            ZStack {
                if #available(iOS 16.0, *) {
                    NavigationLink(destination: {
                        ScannerDemoView()
                    }, label: {
                        Text("Scanner Demo")
                    })
                } else {
                    Text("Scanner Feature Not Supported For You OS Version")
                }
            }.frame(height: 40)
            // 拍照识别：不支持中文
            NavigationLink(destination: {
                DocScanDemoView()
            }, label: {
                Text("Docs Scan Demo")
            }).frame(height: 40)
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("AI Vision Demo")
    }
}

struct VisionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VisionDemoView()
    }
}
