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
    @State var firstEditState: String = ""
    @State var text: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.linearGradient(.init(colors: [.red, .blue, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                // 加了这个属性之后背景就不会随着软键盘改变了
                .ignoresSafeArea(.all)
            ScrollView(content: {
                VStack {
                    Text("State [\(self.firstEditState)]")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                    HStack {
                        Text("Account:")
                        TextField("", text: $account, onEditingChanged: { (change) in
                            self.firstEditState = change ? "account editing" : "account not editing"
                        }, onCommit: {
                            self.firstEditState = "account commit"
                        }).padding(10)
                            .frame(height: 50, alignment: .top)
                            .textFieldStyle(.roundedBorder)
                    }
                    Divider()
                    
                    HStack {
                        Text("Password:")
                        SecureField("", text: $password, onCommit: {
                            self.firstEditState = "password commit"
                        }).padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                            .frame(height: 50)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Divider()
                    
                    TextEditor(text: $text)
                        // 设置键盘类型
                        .keyboardType(.phonePad)
                        // 设置对齐方式
                        .multilineTextAlignment(.leading)
                        // 设置光标颜色，默认纯白色光标
                        .accentColor(.purple)
                        // 输入字体颜色
                        .foregroundColor(.red)
                        // 字体大小
                        .font(.system(size: 16))
                        // 背景
                        .background(Rectangle().fill(.gray.opacity(0.3)))
                        // frame
                        .frame(height: 200)
                        // 圆角
                        .cornerRadius(5)
                        // padding
                        .padding()
                        .border(.gray, width: 1)
                    
                    TextField("", text: $text)
                        .textFieldStyle(.plain)
                        .accentColor(.red)
                        .foregroundColor(.green)
                        .font(.system(size: 16))
                        .frame(height: 50)
                        .textFieldStyle(.automatic)
                        .border(.white, width: 1)
                        .background(Rectangle().fill(.white))
                }
            })
        }.navigationTitle("SwiftUI TextField Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemoView()
    }
}
