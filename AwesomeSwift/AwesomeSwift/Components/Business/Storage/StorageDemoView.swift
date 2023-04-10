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
    
    let documentsProvider = WebDAVFileProvider(
        baseURL: URL(string: "https://dav.jianguoyun.com/dav/")!,
        credential: URLCredential(user: "@163.com", password: "", persistence: .forSession))
    
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
            }
            Button {
                documentsProvider?.create(folder: "awesomeswift", at: "/", completionHandler: { error in
                    tip = "\(error)"
                })
            } label: {
                Text("Create Directories")
            }

            // Archive files.
            Button {
                archiveTaskDBData()
            } label: {
                Text("Archive Zip")
            }
            Button {
                unarchiveZipFile()
            } label: {
                Text("Unarchive Zip")
            }

        }.padding(.top, 10)
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
    
    private func archiveTaskDBData() {
        let fm = FileManager.default
        var docDir = try! fm.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        let taskDBDir = docDir.appendingPathComponent("TaskDB").path
        let zipFilePath = docDir.appendingPathComponent("test.zip").path
        tip = "archive:\n\(zipFilePath) \nfor:\n\(taskDBDir)"
        SSZipArchive.createZipFile(atPath: zipFilePath, withContentsOfDirectory: taskDBDir)
    }
    
    private func unarchiveZipFile() {
        let fm = FileManager.default
        var docDir = try! fm.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        let unzipDir = docDir.appendingPathComponent("ziptest").path
        let zipFilePath = docDir.appendingPathComponent("test.zip").path
        SSZipArchive.unzipFile(atPath: zipFilePath, toDestination: unzipDir)
    }
    
    private func onAppear() {
    }
}

struct StorageDemoView_Previews: PreviewProvider {
    static var previews: some View {
        StorageDemoView()
    }
}
