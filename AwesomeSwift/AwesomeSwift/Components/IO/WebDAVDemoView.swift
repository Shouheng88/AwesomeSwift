//
//  WebDAVDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2023/9/6.
//

import SwiftUI
import FilesProvider

/// WebDAV 示例
struct WebDAVDemoView: View {
    
    @State private var tip: String = ""
    
    private static let ACCOUNT = ""
    private static let PASSWORD = ""
    
    /// Usage: https://github.com/amosavian/FileProvider
    private let documentsProvider = WebDAVFileProvider(
        baseURL: URL(string: "https://dav.jianguoyun.com/dav/")!,
        credential: URLCredential(user: WebDAVDemoView.ACCOUNT, password: WebDAVDemoView.PASSWORD, persistence: .permanent))
    
    var body: some View {
        ScrollView {
            VStack {
                Text(tip)
                
                Button {
                    listAllContents()
                } label: {
                    Text("列举所有的文件和目录")
                }.frame(height: 44)
                
                Button {
                    createFolder()
                } label: {
                    Text("创建目录")
                }.frame(height: 44)
                
                Button {
                    writeToWebDAVCustom()
                } label: {
                    Text("写入到文件（基于 FilesProvider）")
                }.frame(height: 44)
                
                Button {
                    writeToWebDAV()
                } label: {
                    Text("写入到文件（自定义）")
                }.frame(height: 44)
            }
        }.navigationTitle("WebDAV 示例").navigationBarTitleDisplayMode(.inline)
    }
    
    private func listAllContents() {
        print("invoked!")
        documentsProvider?.contentsOfDirectory(path: "/", completionHandler: { contents, error in
            var text = ""
            contents.forEach { content in
                text += "\(content.name)"
            }
            text += "\(String(describing: error))"
            tip = text
        })
    }
    
    private func createFolder() {
        documentsProvider?.create(folder: "awesomeswift", at: "/", completionHandler: { error in
            tip = "\(String(describing: error))"
        })
    }
    
    private func writeToWebDAVCustom() {
        let docDir = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        tip = "fucking creating ..."
        let zipFilePath = docDir.appendingPathComponent("test.zip")
        //                let data = try! Data(contentsOf: zipFilePath)
        let data = "Fuckkkkkkkkkkk!".data(using: .utf8)
        documentsProvider?.writeContents(path: "/tnt/tnt/test.txt",
                                         contents: data,
                                         atomically: true,
                                         overwrite: true,
                                         completionHandler: { error in
            if error != nil {
                tip = "failed freate \(String(describing: error?.localizedDescription))"
            } else {
                tip = "succeed create"
            }
        })
    }
    
    private func writeToWebDAV() {
        // 设置上传文件的路径和 WebDAV 服务器的 URL
        let serverURL = URL(string: "https://dav.jianguoyun.com/dav/biubiubiu/heeello.txt")!
        
        // 创建 URL 请求
        var request = URLRequest(url: serverURL)
        request.httpMethod = "PUT"
        
        // 读取文件数据
        let fileData = "HEEEEEEEEEEEEEll WORLD!".data(using: .utf8)!
        
        // 设置请求头
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        request.setValue("\(fileData.count)", forHTTPHeaderField: "Content-Length")
        
        // 设置请求体
        request.httpBody = fileData
        
        // 设置身份验证信息
        let username = WebDAVDemoView.ACCOUNT
        let password = WebDAVDemoView.PASSWORD
        let authData = "\(username):\(password)".data(using: .utf8)!
        let authString = authData.base64EncodedString()
        request.setValue("Basic \(authString)", forHTTPHeaderField: "Authorization")
        
        // 创建 URLSession 实例并发送请求
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                tip = "Error: \(error)"
            } else if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                tip = "File uploaded successfully."
            } else {
                tip = "Unexpected response: \(response.debugDescription)"
            }
        }
        
        task.resume()
    }
}

struct WebDAVDemoView_Previews: PreviewProvider {
    static var previews: some View {
        WebDAVDemoView()
    }
}
