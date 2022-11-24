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

    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    @State private var emailState: String = ""
    
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
            
            Button(action: {
               self.isShowingMailView.toggle()
            }) {
                Text("Send Email")
            }
            .frame(height: 40)
            .disabled(!MFMailComposeViewController.canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: self.$result)
            }
            
            Button("Send Email by URL", action: {
                sendEmailByUrl()
            }).frame(height: 40)
            Text(emailState)
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
    
    private func sendEmailByUrl() {
        let subject = "Sample Email Subject"
        let body = "Sample message body"
        let mailto = "mailto:shouheng2015@gmail.com?subject=\(subject)&body=\(body)"

        guard let escapedMailto = mailto.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            self.emailState = "email addingPercentEncoding failed"
            return
        }
        guard let url = URL(string: escapedMailto) else {
            self.emailState = "email url encode failed"
            return
        }

        guard UIApplication.shared.canOpenURL(url) else {
            self.emailState = "canOpenURL: Unable to determine email sending state"
            return
        }

        UIApplication.shared.open(url, options: [.universalLinksOnly : false]) { (success) in
            // Handle success/failure
            if !success {
                self.emailState = "Unable to determine email sending state"
            }
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
