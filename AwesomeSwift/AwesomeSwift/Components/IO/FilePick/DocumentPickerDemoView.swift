//
//  DocumentPickerDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/29.
//

import SwiftUI

/// 文件选择示例
struct DocumentPickerDemoView: View {
    
    @State private var showingDocumentPicker = false
    @State private var tip: String = ""
    
    var body: some View {
        VStack {
            Text(tip).foregroundColor(.gray).font(.system(size: 12))
            Button("选择文件", action: {
                self.showingDocumentPicker = true
            }).frame(height: 40)
        }
        .sheet(isPresented: $showingDocumentPicker, content: {
            DocumentPicker(callback: { urls in
                if urls == nil {
                    self.tip = "什么都没选"
                } else {
                    self.tip = "选择这些文件: \n" + "\n - ".join(list: urls!)
                }
            })
        }).navigationTitle("文件选择示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct DocumentPickerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPickerDemoView()
    }
}
