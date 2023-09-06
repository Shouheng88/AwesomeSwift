//
//  LaunchPhonePageDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI
import StoreKit
import MessageUI

//@available(iOS 16.0, *)
struct LaunchPhonePageDemo: View {
    
//    @Environment(\.requestReview) var requestReview
    
    @AppStorage("runsSinceLastRequest") static var runsSinceLastRequest = 0
    @AppStorage("version") static var version = ""
    static var limit = 10

    private var showAppReviewDemo: some View {
        VStack {
            Text("距离上次请求评分 [\(LaunchPhonePageDemo.runsSinceLastRequest)]")
            Text("评分的版本 [\(LaunchPhonePageDemo.version)]")

            Button("请求评分 (16.0 之前的版本)", action: {
                if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }).frame(height: 40)
            
            Button("请求评分 (16.0 之前的版本)", action: {
                LaunchPhonePageDemo.showReview()
            }).frame(height: 40)
            
            Button("请求评分 (16.0 及以上)", action: {
//                requestReview()
                // Use this method on 16.0 and above.
            }).frame(height: 40)
        }
    }
    
    var body: some View {
        VStack {
            Button("打开应用设置", action: {
                openAppSpecificSettings()
            }).frame(height: 40)
            Button("外部打开网页", action: {
                openWebpageExternal()
            }).frame(height: 40)
            showAppReviewDemo
        }.navigationTitle("打开页面").navigationBarTitleDisplayMode(.inline)
    }
    
    // https://stackoverflow.com/a/52103305/1477298
    private func openAppSpecificSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            return
        }

        let optionsKeyDictionary = [UIApplication.OpenExternalURLOptionsKey(rawValue: "universalLinksOnly"): NSNumber(value: true)]
        UIApplication.shared.open(url, options: optionsKeyDictionary, completionHandler: nil)
    }
    
    private func openWebpageExternal() {
        guard let url = URL(string: "https://github.com") else { return }
        UIApplication.shared.open(url)
    }
    
    static func showReview() {
        runsSinceLastRequest += 1
        let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let currentVersion = "Version \(appVersion), build \(appBuild)"

        guard currentVersion != version else {
            runsSinceLastRequest = 0
            return
        }

        guard runsSinceLastRequest == limit else { return }

        if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
            // Reset runsSinceLastRequest
            runsSinceLastRequest = 0
            // Set version to currentVersion
            version = currentVersion
        }
    }
}

struct LaunchPhonePageDemo_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 16.0, *) {
            LaunchPhonePageDemo()
        } else {
            EmptyView()
        }
    }
}
