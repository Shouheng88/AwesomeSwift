//
//  FormDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI

/// 表单示例
struct FormDemoView: View {
    
    @State var account: String = ""
    @State var password: String = ""
    @State var number: String = ""
    @State var emailAddress: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("结果展示区")) {
                Text("账号输入结果: \(self.account)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Text("密码输入结果: \(self.password)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Text("数字输入结果: \(self.number)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Text("邮件输入结果: \(self.emailAddress)")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
            }
            Section(header: Text("账号和密码输入")) {
                if #available(iOS 15.0, *) {
                    TextField(text: $account, label: {
                        Text("请输入你的账号")
                    })
                } else {
                    TextField("请输入你的账号", text: $account)
                }
                if #available(iOS 15.0, *) {
                    SecureField(text: $password, prompt: Text("请输入你的密码"), label: {
                        Text("输入你的密码 Label")
                    })
                } else {
                    SecureField("输入你的密码", text: $password)
                }
            }
            Section(header: Text("数字输入框")) {
                if #available(iOS 15.0, *) {
                    TextField("请输入数字", text: $number)
                        .keyboardType(.numberPad)
                } else {
                    TextField("请输入数字", text: $number)
                        .keyboardType(.numberPad)
                }
            }
            Section(header: Text("邮箱输入框")) {
                if #available(iOS 15.0, *) {
                    TextField(text: $emailAddress, label: {
                        Text("请输入你的邮箱")
                    })
                } else {
                    TextField("请输入你的邮箱", text: $emailAddress)
                        .keyboardType(.emailAddress)
                }
            }
        }.navigationTitle("表单示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct FormDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FormDemoView()
    }
}


