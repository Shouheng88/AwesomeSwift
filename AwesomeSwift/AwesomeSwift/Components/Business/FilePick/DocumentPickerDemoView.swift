//
//  DocumentPickerDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/29.
//

import SwiftUI

struct DocumentPickerDemoView: View {
    
    @State private var showingDocumentPicker = false
    @State private var tip: String = ""
    
    var body: some View {
        VStack {
            Text(tip).foregroundColor(.gray).font(.system(size: 12))
            Button("Pick Document", action: {
                self.showingDocumentPicker = true
            })
        }
        .sheet(isPresented: $showingDocumentPicker, content: {
            DocumentPicker(callback: { urls in
                if urls == nil {
                    self.tip = "Selected nothing"
                } else {
                    self.tip = "Selected: \n" + "\n - ".join(list: urls!)
                }
            })
        }).navigationTitle("Document Pick Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct DocumentPickerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentPickerDemoView()
    }
}
