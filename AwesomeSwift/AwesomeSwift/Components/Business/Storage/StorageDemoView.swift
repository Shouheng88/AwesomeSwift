//
//  StorageDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import SwiftUI

struct StorageDemoView: View {
    
    @State private var useDefaultInput: String = ""
    
    private var useDefaultsSampleView: some View {
        VStack {
            Text("Last input value: \(KV.testStringValue)")
            HStack {
                TextField("Input value", text: $useDefaultInput)
                    .frame(height: 40)
                Button(action: {
                    KV.testStringValue = useDefaultInput
                }, label: {
                    Text("OK").foregroundColor(.white)
                }).padding(10)
                    .background(Rectangle().fill(.blue))
                    .cornerRadius(10)
            }
            Divider()
        }.padding(.top, 10)
    }
    
    var body: some View {
        ScrollView(content: {
            VStack {
                useDefaultsSampleView
                Spacer()
            }.padding(.horizontal, 15)
        }).navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
    }
}

struct StorageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        StorageDemoView()
    }
}
