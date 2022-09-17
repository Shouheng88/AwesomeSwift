//
//  TextFieldView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct TextFieldDemoView: View {

    @State var account: String = ""
    
    @State var password: String = ""
    
    @State var number: String = ""
    
    @State var emailAddress: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("账号")
                TextField("", text: $account, onEditingChanged: { (change) in
                    /// 监听输入框是否获取到焦点
                    print("账号输入框 状态 [\(change)]")
                }, onCommit: {
                    // 按下回车键的时候调用
                    print("账号输入框 commit [\(account)]")
                }).padding(10)
                    .frame(width: 200, height: 50, alignment: .top)
                    .textFieldStyle(.roundedBorder)
            }
            /// 仍然存在一些问题：
            /// 1、如何对输入做限制？比如限制数字等
            /// 2、长文本什么的如何输入？
            HStack {
                Text("密码")
                SecureField("", text: $password, onCommit: {
                    print("密码输入框 commit [\(password)]")
                }).padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .frame(height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Form {
                TextField(text: $account, label: {
                    Text("Fucking account")
                })
                TextField(text: $password, label: {
                    Text("Fucking password")
                })
                Section(header: Text("HEADER")) {
                    TextField(text: $number, label: {
                        Text("Number only")
                    }).keyboardType(.numberPad)
                }
                Section(header: Text("HEADER")) {
                    TextField(text: $emailAddress, label: {
                        Text("Email")
                    }).keyboardType(.emailAddress)
                }
            }
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemoView()
    }
}
