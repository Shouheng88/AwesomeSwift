//
//  SectionDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct SectionDemoView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("Here is a header"), footer: Text("Here is a footer")) {
                    ForEach(0..<20) { index in
                        Text("I'm a list item. My name is \(index)")
                    }
                }
            }.listStyle(GroupedListStyle())
            /// 这里的button怎么就默认在最底部了??
            Button(action: {
                print("呵呵")
            }, label: {
                Text("Button is Here!!")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30, height: 40)
            }).background(Color.orange).cornerRadius(8)
        }
    }
}

struct SectionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SectionDemoView()
    }
}
