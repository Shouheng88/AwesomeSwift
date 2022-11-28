//
//  ImagePickDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/28.
//

import SwiftUI

// 从相机中选择图片，需要添加隐私：Privacy - Camera Usage Description
// TODO: 真机测试相机功能
struct ImagePickDemoView: View {
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack {
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            }
            Button("Select a picture from photo library", action: {
                self.sourceType = .photoLibrary
                self.showingImagePicker = true
            }).frame(height: 40)
            Button("Select a picture from camera", action: {
                self.sourceType = .camera
                self.showingImagePicker = true
            }).frame(height: 40)
            Text("Photo library available: \(String(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)))")
                .font(.system(size: 12)).foregroundColor(.gray)
            Text("Camera available: \(String(UIImagePickerController.isSourceTypeAvailable(.camera)))")
                .font(.system(size: 12)).foregroundColor(.gray)
        }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage, sourceType: self.sourceType)
        }.navigationTitle("Image Pick Demo")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    func loadImage() {
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
