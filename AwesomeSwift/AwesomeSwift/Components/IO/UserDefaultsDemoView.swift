//
//  StorageDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import SwiftUI
import FilesProvider
import SSZipArchive

/// 键值对存储示例
struct UserDefaultsDemoView: View {
    
    @State private var useDefaultInput: String = ""
    
    private var useDefaultsSampleView: some View {
        VStack {
            Text("上次输入的值：\(KV.testStringValue)")
            HStack {
                TextField("请输入...", text: $useDefaultInput)
                    .frame(height: 40)
                Button(action: {
                    KV.testStringValue = useDefaultInput
                }, label: {
                    Text("存储").foregroundColor(.white)
                }).padding(10)
                    .background(Rectangle().fill(.blue))
                    .cornerRadius(10)
            }
        }.padding(.top, 10)
    }
    
    var body: some View {
        ScrollView(content: {
            VStack {
                useDefaultsSampleView
                Spacer()
            }.padding(.horizontal, 15)
        }).navigationBarTitleDisplayMode(.inline).navigationTitle("键值对存储示例")
            .onAppear(perform: onAppear)
    }
    
    private func onAppear() {
    }
}

struct StorageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultsDemoView()
    }
}
