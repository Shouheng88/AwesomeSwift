//
//  FormDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI

struct FormDemoView: View {
    
    @State var account: String = ""
    @State var password: String = ""
    @State var number: String = ""
    @State var emailAddress: String = ""

    var body: some View {
        VStack {
            Text("Account input result: \(self.account)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            Text("Password input result: \(self.password)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            Text("Number input result: \(self.number)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            Text("Email input result: \(self.emailAddress)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            Form {
                if #available(iOS 15.0, *) {
                    TextField(text: $account, label: {
                        Text("Please input your account")
                    })
                } else {
                    TextField("Please input your account", text: $account)
                }
                TextField("Please input your account", text: $account)
                if #available(iOS 15.0, *) {
                    SecureField(text: $password, prompt: Text("This is the prompt"), label: {
                        Text("Please input your password")
                    })
                } else {
                    SecureField("Please input your password", text: $password)
                }
                Section(header: Text("Number Only Section")) {
                    if #available(iOS 15.0, *) {
                        TextField("Please input your number", text: $number)
                            .keyboardType(.numberPad)
                    } else {
                        TextField("Please input your number", text: $number)
                            .keyboardType(.numberPad)
                    }
                }
                Section(header: Text("Email Section")) {
                    if #available(iOS 15.0, *) {
                        TextField(text: $emailAddress, label: {
                            Text("Please input your email")
                        })
                    } else {
                        TextField("Please input your email", text: $emailAddress)
                            .keyboardType(.emailAddress)
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct FormDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FormDemoView()
    }
}
