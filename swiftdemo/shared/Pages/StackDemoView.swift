//
//  StackDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct StackDemoView: View {
    var body: some View {
        VStack {
            HStack {
                Text("LEFT TOP")
                Divider()
                Text("RIGHT TOP")
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
        StackDemoView()
    }
}
