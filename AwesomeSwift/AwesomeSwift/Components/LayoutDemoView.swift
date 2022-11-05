//
//  StackDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct LayoutDemoView: View {
    var body: some View {
        VStack {
            HStack {
                Text("LEFT TOP")
                Divider()
                Text("RIGHT TOP")
            }
            Divider()
            HStack(alignment: .bottom) {
                Text("1")
                Divider()
                Text("2")
            }
            Divider()
            HStack(alignment: .top) {
                Text("3")
                Divider()
                Text("4")
            }
            Divider()
            HStack {
                Text("LEFT BOTTOM")
                Divider()
                ZStack {
                    Text("RIGHT")
                    Text("BOTTOM")
                }
            }
        }
    }
}

struct StackDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemoView()
    }
}
