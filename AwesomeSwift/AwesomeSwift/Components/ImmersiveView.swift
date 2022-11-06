//
//  ImmersiveView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/6.
//

import SwiftUI

struct ImmersiveView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Hi, there!").foregroundColor(.white)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Exit").foregroundColor(.white)
                }).frame(height: 40)
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color(R.color.custom_color()!))
        }.edgesIgnoringSafeArea([.top, .leading, .trailing])
            .navigationBarHidden(true)
    }
}

struct ImmersiveView_Previews: PreviewProvider {
    static var previews: some View {
        ImmersiveView()
    }
}
