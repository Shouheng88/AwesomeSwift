//
//  EmailDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/24.
//

import SwiftUI
import MessageUI

struct EmailDemoView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    @State private var emailState: String = ""
    
    var body: some View {
        VStack {
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
    
}

struct EmailDemoView_Previews: PreviewProvider {
    static var previews: some View {
        EmailDemoView()
    }
}
