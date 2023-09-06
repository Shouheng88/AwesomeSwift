//
//  TabPageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/18.
//

import SwiftUI

/// Tab 页面
struct TabPageDemoView: View {

    @State var selection: Int = 0
    
    struct SimpleTab: View {
        let image: String
        let text: String
        
        var body: some View {
            return HStack {
                Image(systemName: image).font(.system(size: 14))
                Text(text).font(.system(size: 14))
            }
        }
    }
    
    var body: some View {
        VStack {
            VStack {
                Picker(selection: $selection, content: {
                    ForEach(0..<3) { idx in
                        Text("标签 \(idx)")
                    }
                }, label: {
                    Text("")
                }).pickerStyle(SegmentedPickerStyle())
                Picker(selection: $selection, content: {
                    ForEach(0..<3) { idx in
                        SimpleTab(image: "trash", text: "标签 \(idx)")
                    }
                }, label: {
                    Text("")
                }).pickerStyle(InlinePickerStyle())
            }
            contentView
        }.padding(15).navigationTitle("TAB 示例").navigationBarTitleDisplayMode(.inline)
    }
    
    private var contentView: some View {
        switch selection {
        case 0:
            return AnyView(
                ZStack {
                    Color.red.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面 1")
                        Spacer()
                    }
                }
            )
        case 1:
            return AnyView(
                ZStack {
                    Color.green.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面 2")
                        Spacer()
                    }
                }
            )
        case 2:
            return AnyView(
                ZStack {
                    Color.blue.opacity(0.1).ignoresSafeArea(.all)
                    VStack(alignment: .trailing) {
                        Spacer()
                        Text("页面 3")
                        Spacer()
                    }
                }
            )
        default:
            return AnyView(VStack {
                Form {
                    Text("Default 😅")
                }
            })}
    }
}

struct TabPageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TabPageDemoView()
    }
}
