//
//  ImmersiveView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/6.
//

import SwiftUI

/// 全屏页面
struct ImmersiveView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack(content: {
            Color.green.opacity(0.5).ignoresSafeArea(.all)
            ScrollView {
                VStack(alignment: .center, spacing: 15) {
                    Text("这是一个全屏页面")
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("退出")
                    })
                }.padding(.top, UIScreen.main.bounds.height / 2)
            }
        }).navigationBarHidden(true)
    }
}

struct ImmersiveView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveView()
    }
}
