//
//  ButtonDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct ButtonDemoView: View {
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    print("你点击了普通按钮")
                }, label: {
                    Text("普通按钮")
                }).padding(5)
                    .border(.black, width: 2)
                    .cornerRadius(10, antialiased: true)
                
                Button(action: {
                    print("你点击了按钮")
                }, label: {
                    Text("按钮")
                }).background(.gray)
                    .padding(5)
                    .cornerRadius(10, antialiased: true)
                
                Button(action: {
                    print("你点击了按钮")
                }, label: {
                    Text("按钮").padding(8)
                }).background(.gray)
    //                .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .cornerRadius(10, antialiased: false)
            }
            
            NavigationLink(destination: {
                Text("Hello!!!")
            }, label: {
                Text("跳转按钮")
            })
            
            List {
                ForEach(0..<4) { i in
                    // 这样的方式只有点击 text 的时候有效
                    Text("Hello \(i)").onTapGesture {
                        print("点击了 No.\(i)")
                    }
                }.onDelete(perform: { idx in
                    print("on delete")
                }).onMove { IndexSet, Int in
                    print("on move")
                }
            }
        }
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemoView()
    }
}
