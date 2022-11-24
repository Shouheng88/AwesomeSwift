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
            Text("Review runsSinceLastRequest [\(LaunchPhonePageDemo.runsSinceLastRequest)]")
            Text("Review version [\(LaunchPhonePageDemo.version)]")

            Button("Request Review (before 16.0)", action: {
                if let scene = UIApplication.shared.connectedScenes.first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
            }).frame(height: 40)
            
            Button("Request Review (before 16.0)", action: {
                LaunchPhonePageDemo.showReview()
            }).frame(height: 40)
            
            Button("Request Review (16.0 and above)", action: {
//                requestReview()
                // Use this method on 16.0 and above.
            }).frame(height: 40)
        }
    }
    
    var body: some View {
        VStack {
            Button("Open App Settings", action: {
                openAppSpecificSettings()
            }).frame(height: 40)
            showAppReviewDemo
        }
    }
    
    // https://stackoverflow.com/a/52103305/1477298
    private func openAppSpecificSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            return
        }

        let optionsKeyDictionary = [UIApplication.OpenExternalURLOptionsKey(rawValue: "universalLinksOnly"): NSNumber(value: true)]
        UIApplication.shared.open(url, options: optionsKeyDictionary, completionHandler: nil)
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
