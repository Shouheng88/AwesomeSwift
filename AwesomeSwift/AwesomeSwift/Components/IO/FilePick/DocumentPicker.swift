//
//  DocumentPicker.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/29.
//

import Foundation
import SwiftUI
import UIKit

struct DocumentPicker : UIViewControllerRepresentable {
    
    var callback : ([URL]?) -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator : NSObject, UIDocumentPickerDelegate {
        var parent : DocumentPicker
        
        init(_ parent : DocumentPicker){
            self.parent = parent
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            self.parent.callback(nil)
            print("Cancelled picking document")
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            self.parent.callback(urls)
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeUIViewController(context: Context) ->  UIDocumentPickerViewController {
        let options = ["public.image", "public.jpeg", "public.png", "public.pdf",
                       "public.text", "public.video", "public.audio", "public.text",
                       "public.data", "public.zip-archive"]
        let picker = UIDocumentPickerViewController(documentTypes: options, in: .import)
        picker.allowsMultipleSelection = true
        picker.modalPresentationStyle = .fullScreen
        picker.delegate = context.coordinator
        return picker
    }
}
