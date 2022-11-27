//
//  FileDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/27.
//

import SwiftUI

struct FileDemoView: View {
    
    private var documentDirectoryUrl: URL {
        try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    }
    
    private var contentsOfDocumentDirectory: String {
        let urls = try! FileManager.default.contentsOfDirectory(
            at: documentDirectoryUrl, includingPropertiesForKeys: nil)
        return "- " + "\n- ".join(list: urls)
    }
    
    private var directoryInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            DirectoryInfoView(message: ".documentDirectory:\n \(urlFor(for: .documentDirectory))")
            DirectoryInfoView(message: ".userDirectory:\n \(urlFor(for: .userDirectory))")
            DirectoryInfoView(message: ".applicationDirectory:\n \(urlFor(for: .applicationDirectory))")
            DirectoryInfoView(message: ".developerDirectory:\n \(urlFor(for: .developerDirectory))")
            DirectoryInfoView(message: ".libraryDirectory:\n \(urlFor(for: .libraryDirectory))")
            DirectoryInfoView(message: ".musicDirectory:\n \(urlFor(for: .musicDirectory))")
            DirectoryInfoView(message: ".trashDirectory:\n \(urlFor(for: .trashDirectory))")
            DirectoryInfoView(message: ".applicationSupportDirectory:\n \(urlFor(for: .applicationSupportDirectory))")
            DirectoryInfoView(message: ".documentDirectory content:\n \(contentsOfDocumentDirectory)")
        }.onAppear(perform: {
            // 另外一种查看模拟器里的目录的方式是，将以下打印出的内容在 Finder 中选择 “前往->前往文件夹”，输入，然后可以进入对应目录
            print(urlFor(for: .documentDirectory))
        })
    }
    
    private var fileOptionsView: some View {
        VStack {
            Button("", action: {
                
            })
        }
    }
    
    private var folderOptionsView: some View {
        VStack {
            Button("Create Folder", action: {
                createFolder()
            }).frame(height: 40)
            Button("Create Sub Folder", action: {
                createSubFolder()
            }).frame(height: 40)
        }
    }
    
    private func createFolder() {
        do {
            let fm = FileManager.default
            let docsUrl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folder = docsUrl.appendingPathComponent("test_folder")
            try fm.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch {
            print("failed to create folder")
        }
    }
    
    private func createSubFolder() {
        do {
            let fm = FileManager.default
            let docsUrl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folder = docsUrl.appendingPathComponent("test_folder").appendingPathComponent("test_folder")
            try fm.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch {
            print("failed to create folder")
        }
    }
    
    private func renameFolder() {
        do {
            let fm = FileManager.default
            let docsUrl = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let folder = docsUrl.appendingPathComponent("test_folder").appendingPathComponent("test_folder")
            try fm.createDirectory(at: folder, withIntermediateDirectories: true)
        } catch {
            print("failed to create folder")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                directoryInfoView
                folderOptionsView
                fileOptionsView
            }
        }.navigationBarTitleDisplayMode(.inline)
            .navigationTitle("File Demo")
    }
    
    private func urlFor(for directory: FileManager.SearchPathDirectory) -> String {
        do {
            let fm = FileManager.default
            let docsUrl = try fm.url(
                for: directory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            return "\(docsUrl)"
        } catch {
            return "--"
        }
    }
}

extension String {
    func join(list: [Any]) -> String {
        var ret = ""
        let len = list.count
        for index in 0..<len {
            ret += "\(list[index])"
            if index != len-1 {
                ret += self
            }
        }
        return ret
    }
}

struct DirectoryInfoView: View {
    
    let message: String
    
    private var messageTitle: String {
        "\(message.split(separator: "\n")[0])"
    }

    private var messageBody: String {
        let firstIndex = message.firstIndex(where: { c in c == "\n" })!
        return String(message[firstIndex...]).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(messageTitle)
                .foregroundColor(Color.black)
                .font(.system(size: 12))
                .bold()
            Text(messageBody)
                .foregroundColor(Color.gray)
                .font(.system(size: 12))
        }.padding(.horizontal, 15)
    }
}

struct FileDemoView_Previews: PreviewProvider {
    static var previews: some View {
        FileDemoView()
    }
}
