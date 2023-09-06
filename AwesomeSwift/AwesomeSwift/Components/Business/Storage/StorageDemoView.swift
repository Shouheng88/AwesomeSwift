//
//  StorageDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import SwiftUI
import FilesProvider
import SSZipArchive

struct StorageDemoView: View {
    
    @State private var useDefaultInput: String = ""
    
    @State private var tip: String = ""
    
    private static let ACCOUNT = ""
    
    private static let PASSWORD = ""
    
    /// Usage: https://github.com/amosavian/FileProvider
    let documentsProvider = WebDAVFileProvider(
        baseURL: URL(string: "https://dav.jianguoyun.com/dav/")!,
        credential: URLCredential(user: StorageDemoView.ACCOUNT, password: StorageDemoView.PASSWORD, persistence: .permanent))
    
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
            
            // WebDAV sample
            Text(tip)
            Button {
                // List contents of directotires
                print("invoked!")
                documentsProvider?.contentsOfDirectory(path: "/", completionHandler: { contents, error in
                    var text = ""
                    contents.forEach { content in
                        text += "\(content.name)"
                    }
                    text += "\(error)"
                    tip = text
                })
            } label: {
                Text("List Root Directory")
            }.frame(height: 44)
            
            Button {
                documentsProvider?.create(folder: "awesomeswift", at: "/", completionHandler: { error in
                    tip = "\(error)"
                })
            } label: {
                Text("Create Directories")
            }.frame(height: 44)
            
            Button {
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
                        tip = "failed freate \(error?.localizedDescription)"
                    } else {
                        tip = "succeed create"
                    }
                })
            } label: {
                 Text("Create file")
            }.frame(height: 44)
            
            Button {
                writeToWebDAV()
            } label: {
                 Text("Create file Custom")
            }.frame(height: 44)
        }.padding(.top, 10)
    }
    
    func writeToWebDAV() {
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
        let username = StorageDemoView.ACCOUNT
        let password = StorageDemoView.PASSWORD
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
