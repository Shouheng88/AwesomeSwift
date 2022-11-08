//
//  TabPageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/18.
//

import SwiftUI

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
                Text("The tab styled page")
                Picker(selection: $selection, content: {
                    ForEach(0..<3) { idx in
                        Text("TAB \(idx)")
                        // invalid
//                        SimpleTab(image: "trash", text: "TAB \(idx)")
                    }
                }, label: {
                    Text("")
                }).pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(.gray)
                    .background(Rectangle().fill(.purple))
                Picker(selection: $selection, content: {
                    ForEach(0..<3) { idx in
//                        Text("TAB \(idx)")
                        SimpleTab(image: "trash", text: "TAB \(idx)")
                    }
                }, label: {
                    Text("")
                }).pickerStyle(InlinePickerStyle())
            }.padding(10)
            contentView
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    private var contentView: some View {
        switch selection {
        case 0:
            return AnyView(VStack(alignment: .center) {
                Text("First Page")
                Spacer()
            })
        case 1:
            return AnyView(VStack(alignment: .leading) {
                Text("Second Page")
                Spacer()
            })
        case 2:
            return AnyView(VStack(alignment: .trailing) {
                Text("Third Page")
                Spacer()
            })
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
