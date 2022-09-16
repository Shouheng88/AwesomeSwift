//
//  MyImageView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct MyImageView: View {
    
    @State private var image: UIImage? = nil
    private let placeholder: UIImage = UIImage(named: "sample_image")!
    
    var body: some View {
        Image(uiImage: self.image ?? placeholder)
            .onAppear(perform: self.onAppear)
            .frame(width: 100, height: 100, alignment: .center)
    }
    
    /// 使用方式过于繁琐
    /// 无法限制大小？缓存？
    private func onAppear() {
        guard let url = URL(string: "https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png") else {
            print("Invalid url")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, res, err) in
            if let data = data, let image = UIImage(data: data) {
                self.image = image
            } else {
                print("error: \(String(describing: err))")
            }
        }).resume()
    }
}

struct MyImageView_Previews: PreviewProvider {
    static var previews: some View {
        MyImageView()
    }
}
