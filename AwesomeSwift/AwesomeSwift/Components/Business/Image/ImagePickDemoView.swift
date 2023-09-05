//
//  ImagePickDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import SwiftUI

// 从相机中选择图片，需要添加隐私：Privacy - Camera Usage Description
struct ImagePickDemoView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingCameraPicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                }
                Text("相册是否可用: \(String(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)))")
                    .font(.system(size: 14)).foregroundColor(.gray)
                Button("从相册中选择图片", action: {
                    self.showingImagePicker = true
                }).frame(height: 40)
                Text("相机是否可用: \(String(UIImagePickerController.isSourceTypeAvailable(.camera)))")
                    .font(.system(size: 14)).foregroundColor(.gray)
                Button("从相机中获取图片", action: {
                    self.showingCameraPicker = true
                }).frame(height: 40)
            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .photoLibrary)
            }.sheet(isPresented: $showingCameraPicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage, sourceType: .camera)
            }.padding(15)
        }.navigationTitle("图片选择示例").navigationBarTitleDisplayMode(.inline)
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else {
            print("image empty")
            return
        }
        image = Image(uiImage: inputImage)
    }
}

struct ImagePickDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickDemoView()
    }
}
