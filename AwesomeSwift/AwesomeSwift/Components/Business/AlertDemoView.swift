//
//  AlertDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/12/3.
//

import SwiftUI

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
            Spacer()
            Group {
                Button("Toast .regular", action: {
                    self.regularToast.toggle()
                }).frame(height: 40)
                Button("Toast .regular long", action: {
                    self.regularToastLong.toggle()
                }).frame(height: 40)
                Button("Toast .regular long subtitle", action: {
                    self.regularToastLongSubTitle.toggle()
                }).frame(height: 40)
                Button("Toast .error", action: {
                    self.errorToast.toggle()
                }).frame(height: 40)
                Button("Toast .complete", action: {
                    self.completeToast.toggle()
                }).frame(height: 40)
                Button("Toast .loading", action: {
                    self.loadingToast.toggle()
                }).frame(height: 40)
                Button("Toast .systemImage", action: {
                    self.systemImageToast.toggle()
                }).frame(height: 40)
                Button("Toast .systemImage banner pop", action: {
                    self.systemImageBannerPop.toggle()
                }).frame(height: 40)
                Button("Toast .systemImage banner slide", action: {
                    self.systemImageBannerSlide.toggle()
                }).frame(height: 40)
                Button("Toast .systemImage hub", action: {
                    self.systemImageHub.toggle()
                }).frame(height: 40)
            }
        }
        .toast(isPresenting: $regularToast){
            AlertToast(type: .regular, title: "alert_title_short")
        }
        .toast(isPresenting: $regularToastLong){
            AlertToast(type: .regular, title: "alert_title_long")
        }
        .toast(isPresenting: $regularToastLongSubTitle){
            AlertToast(type: .regular, subTitle: "alert_title_long")
        }
        .toast(isPresenting: $errorToast, alert: {
            AlertToast(type: .error(Color.yellow), title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $completeToast, alert: {
            AlertToast(type: .complete(Color.blue), title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $loadingToast, alert: {
            AlertToast(type: .loading, title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $systemImageToast, alert: {
            AlertToast(type: .systemImage("scribble", Color.green), title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $systemImageBannerPop, alert: {
            AlertToast(displayMode: .banner(.pop), type: .systemImage("scribble", Color.green), title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $systemImageBannerSlide, alert: {
            AlertToast(displayMode: .banner(.slide), type: .systemImage("scribble", Color.green), title: "alert_title_short", subTitle: "alert_title_long")
        })
        .toast(isPresenting: $systemImageHub, alert: {
            AlertToast(displayMode: .hud, type: .systemImage("scribble", Color.green), title: "alert_title_short", subTitle: "alert_title_long")
        })
//        .navigationBarHidden(true)
        .navigationTitle("Alert Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
}
