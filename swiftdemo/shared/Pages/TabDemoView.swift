//
//  TabDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct TabDemoView: View {
    
    @State var selection: Int = 0
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<5) { idx in
                Text("Hi \(idx)").tabItem {
                    VStack {
                        Text("title \(idx)").onTapGesture {
                            print("clicked title \(selection)") // invliad
                        }
                        Image("sample_image")
                    }.onTapGesture {
                        print("clicked \(selection)") // invalid
                    }
                }.onTapGesture {
                    print(".....")
                }
            }
        }
        // 下面的代码用于指定 tab 的样式，可以修改样式来将 tab 定义成轮播图
//        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct TabDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TabDemoView()
    }
}
