//
//  VisionDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/30.
//

import SwiftUI

/// AI 视觉示例
struct VisionDemoView: View {
    
    var body: some View {
        VStack {
            // 实时文字识别：16.0 以上才能使用
            ZStack {
                if #available(iOS 16.0, *) {
                    NavigationLink(destination: {
                        ScannerDemoView()
                    }, label: {
                        Text("图像识别示例")
                    })
                } else {
                    Text("你的系统版本不支持该特性")
                }
            }.frame(height: 40)
            // 拍照识别
            NavigationLink(destination: {
                DocScanDemoView()
            }, label: {
                Text("文档扫描示例")
            }).frame(height: 40)
        }.navigationBarTitleDisplayMode(.inline).navigationTitle("AI 视觉示例")
    }
}

struct VisionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VisionDemoView()
    }
}
