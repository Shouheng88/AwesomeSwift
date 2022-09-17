//
//  TabPageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/18.
//

import SwiftUI

struct TabPageDemoView: View {

    @State var selection: Int = 0
    
    var body: some View {
        VStack {
            VStack {
                Text("The tab style")
                Picker(selection: $selection, content: {
                    ForEach(0..<2) { idx in
                        Text("TAB \(idx)")
                    }
                }, label: {
                    Text("")
                }).pickerStyle(SegmentedPickerStyle())
            }.padding(10)
            
            contentView
        }
    }
    
    private var contentView: some View {
        switch selection {
        case 0:
        return AnyView(ZStack(alignment: .center) {
            Form {
                Text("First")
            }
        })
        case 1:
        return AnyView(VStack {
            Form {
                Text("Second")
            }
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
