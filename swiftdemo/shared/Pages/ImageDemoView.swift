//
//  ImageDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct ImageDemoView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("sample_image")
                    .onTapGesture {
                        print("Hello 1x")
                    }
                Image("sample_image")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .bottom)
                    .onTapGesture {
                        print("Hello 30x")
                    }
                Image("sample_image")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .bottom)
                    .onTapGesture {
                        print("Hello 50x")
                    }.blur(radius: 3)
                MyImageView()
            }.navigationTitle(Text("标题啊"))
                .navigationBarHidden(false)
                .navigationViewStyle(.columns)
                .navigationBarItems(leading: Text("Leading"), trailing: Text("Trialing")
                    .onTapGesture { print("呦呵") })
        }
    }
}

struct ImageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDemoView()
    }
}
