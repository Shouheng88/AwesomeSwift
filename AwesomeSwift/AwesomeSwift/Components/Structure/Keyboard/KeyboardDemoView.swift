//
//  KeyboardDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/9.
//

import SwiftUI

struct KeyboardDemoView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: {
                KeyboardAwareDemoView()
            }, label: {
                Text("Keyboard Aware Demo 1")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                if #available(iOS 15.0, *) {
                    KeyboardAwareDemoView2()
                } else {
                    Text("Only available on 15.0 and newer")
                }
            }, label: {
                Text("Keyboard Aware Demo 2")
            }).frame(height: 40)
            
            NavigationLink(destination: {
                KeyboardAwareDemo3()
            }, label: {
                Text("Keyboard Aware Demo 3")
            }).frame(height: 40)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct KeyboardDemoView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardDemoView()
    }
}
