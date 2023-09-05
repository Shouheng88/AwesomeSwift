//
//  TextFieldView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

/// 输入控件示例
struct TextFieldDemoView: View {

    @State var account: String = ""
    @State var password: String = ""
    @State var firstEditState: String = ""
    @State var text: String = ""
    
    private var sampleSingleLineView: some View {
        VStack {
            SampleSectionTitleView(title: "1. 单行输入框", desc: "普通文本输入框 TextField 和密码输入框 SecureField")
            Text("State [\(self.firstEditState)]")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            HStack {
                Text("账号")
                TextField("", text: $account, onEditingChanged: { (change) in
                    self.firstEditState = change ? "账号编辑中" : "账号未编辑"
                }, onCommit: {
                    self.firstEditState = "账号已提交"
                }).padding(10)
                    .frame(height: 50, alignment: .top)
                    .textFieldStyle(.roundedBorder)
            }
            HStack {
                Text("密码")
                SecureField("", text: $password, onCommit: {
                    self.firstEditState = "密码已提交"
                }).padding(10)
                    .frame(height: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
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
    }
    
    private var sampleMultiLineView: some View {
        VStack {
            SampleSectionTitleView(title: "2. 多行输入框")
            TextEditor(text: $text)
                .keyboardType(.phonePad) // 设置键盘类型
                .multilineTextAlignment(.leading) // 设置对齐方式
                .accentColor(.purple) // 设置光标颜色，默认纯白色光标
                .foregroundColor(.red) // 输入字体颜色
                .font(.system(size: 16)) // 字体大小
                .background(Rectangle().fill(.gray.opacity(0.3))) // 背景，无效
                .frame(height: 150) // frame
                .cornerRadius(5) // 圆角
                .padding(5) // padding
                .border(.blue, width: 1)
        }
    }
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).ignoresSafeArea(.all)
            ScrollView {
                VStack {
                    sampleSingleLineView
                    sampleMultiLineView
                }.padding(15)
            }
        }.navigationTitle("输入控件示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldDemoView()
    }
}
