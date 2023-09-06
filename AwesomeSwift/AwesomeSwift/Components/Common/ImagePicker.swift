//
//  ImagePicker.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import Foundation
import UIKit
import SwiftUI

/// 图片选择
struct ImagePicker: UIViewControllerRepresentable {

    @Binding var image: UIImage? // 用于存放UIImage

    var sourceType: UIImagePickerController.SourceType

    @Environment(\.presentationMode) var presentationMode // 获取环境变量

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker // 存放ImagePicker的引用
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // 设置图片选取回调
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            print("image pick")
            if let uiImage = info[.originalImage] as? UIImage { // 从info中获取原始图片，并转换为UIImage类型
                parent.image = uiImage // 将数据返回
            }
            parent.presentationMode.wrappedValue.dismiss(); // 关闭嵌套视图。
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("image pick canceled!")
            parent.presentationMode.wrappedValue.dismiss(); // 关闭嵌套视图。
        }
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator // 设置代理，从上下文中获取代理对象
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
    
    // 有内联类的情况下，必须创建一个初始化内联类对象的方法，
    // 系统会自动调用这个函数创建内联类的对象，并将其绑定到context（上下文）中。
    func makeCoordinator() -> Coordinator {
        Coordinator(self) // 当方法内只有一行时，默认将这一行的结果返回
    }
}
