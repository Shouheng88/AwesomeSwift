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
                TextField(text: $account, label: {
                    Text("Please input your account")
                })
                SecureField(text: $password, prompt: Text("This is the prompt"), label: {
                    Text("Please input your password")
                })
                Section(header: Text("Number Only Section")) {
                    TextField(text: $number, label: {
                        Text("Please input your number")
                    }).keyboardType(.numberPad)
                }
                Section(header: Text("Email Section")) {
                    TextField(text: $emailAddress, label: {
                        Text("Please input your email")
                    }).keyboardType(.emailAddress)
                }
            }
        }
    }
}

struct FormDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FormDemoView()
    }
}
