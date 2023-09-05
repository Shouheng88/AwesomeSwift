//
//  AlertDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/12/3.
//

import SwiftUI

/// 提示示例
struct AlertDemoView: View {
    
    @State private var regularToast: Bool = false
    @State private var regularToastLong: Bool = false
    @State private var regularToastLongSubTitle: Bool = false
    @State private var errorToast: Bool = false
    @State private var completeToast: Bool = false
    @State private var loadingToast: Bool = false
    @State private var systemImageToast: Bool = false
    @State private var systemImageBannerPop: Bool = false
    @State private var systemImageBannerSlide: Bool = false
    @State private var systemImageHub: Bool = false

    var body: some View {
        VStack {
            Group {
                Button("弹出 .regular 类型", action: {
                    self.regularToast.toggle()
                }).frame(height: 40)
                Button("弹出 .regular 类型", action: {
                    self.regularToastLong.toggle()
                }).frame(height: 40)
                Button("弹出 .regular 类型", action: {
                    self.regularToastLongSubTitle.toggle()
                }).frame(height: 40)
                Button("弹出 .error 类型", action: {
                    self.errorToast.toggle()
                }).frame(height: 40)
                Button("弹出 .complete 类型", action: {
                    self.completeToast.toggle()
                }).frame(height: 40)
                Button("弹出 .loading 类型", action: {
                    self.loadingToast.toggle()
                }).frame(height: 40)
                Button("弹出 .systemImage 类型", action: {
                    self.systemImageToast.toggle()
                }).frame(height: 40)
                Button("弹出 .banner(.pop) 类型", action: {
                    self.systemImageBannerPop.toggle()
                }).frame(height: 40)
                Button("弹出 .banner(.slide) 类型", action: {
                    self.systemImageBannerSlide.toggle()
                }).frame(height: 40)
                Button("弹出 .hub 类型", action: {
                    self.systemImageHub.toggle()
                }).frame(height: 40)
            }
        }
        .toast(isPresenting: $regularToast){
            AlertToast(type: .regular, title: "标题")
        }
        .toast(isPresenting: $regularToastLong){
            AlertToast(type: .regular, title: "标题")
        }
        .toast(isPresenting: $regularToastLongSubTitle){
            AlertToast(type: .regular, subTitle: "副标题")
        }
        .toast(isPresenting: $errorToast, alert: {
            AlertToast(type: .error(Color.red), title: "错误", subTitle: "副标题")
        })
        .toast(isPresenting: $completeToast, alert: {
            AlertToast(type: .complete(Color.green), title: "已完成", subTitle: "副标题")
        })
        .toast(isPresenting: $loadingToast, alert: {
            AlertToast(type: .loading, title: "标题", subTitle: "副标题")
        })
        .toast(isPresenting: $systemImageToast, alert: {
            AlertToast(type: .systemImage("scribble", Color.green), title: "标题", subTitle: "副标题")
        })
        .toast(isPresenting: $systemImageBannerPop, alert: {
            AlertToast(displayMode: .banner(.pop), type: .systemImage("scribble", Color.green), title: "标题", subTitle: "副标题")
        })
        .toast(isPresenting: $systemImageBannerSlide, alert: {
            AlertToast(displayMode: .banner(.slide), type: .systemImage("scribble", Color.green), title: "标题", subTitle: "副标题")
        })
        .toast(isPresenting: $systemImageHub, alert: {
            AlertToast(displayMode: .hud, type: .systemImage("scribble", Color.green), title: "标题", subTitle: "副标题")
        })
        .navigationTitle("提示示例").navigationBarTitleDisplayMode(.inline)
    }
}
