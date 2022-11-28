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
    
    // 深度遍历指定目录
    private var contentsOfDocumentDirectoryDepth: String {
        let paths = FileManager.default.enumerator(atPath: documentDirectoryUrl.path)
        return "- " + "\n- ".join(list: paths?.allObjects ?? [])
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
            DirectoryInfoView(message: "contentsOfDocumentDirectoryDepth:\n \(contentsOfDocumentDirectoryDepth)")
        }.onAppear(perform: {
            // 另外一种查看模拟器里的目录的方式是，将以下打印出的内容在 Finder 中选择 “前往->前往文件夹”，输入，然后可以进入对应目录
            print(urlFor(for: .documentDirectory))
        })
    }
    
    private var fileOptionsView: some View {
        VStack {
            Text("Sample text file exists: \(String(sampleFileExists()))").frame(height: 40)
            Button("Write Text To File", action: {
                writeTextToFile()
            }).frame(height: 40)
            Button("Write Image To File", action: {
                writeImageToFile()
            }).frame(height: 40)
            Button("Write Data To File", action: {
                writeDataToFile()
            }).frame(height: 40)
            Button("Copy File", action: {
                copyFile()
            }).frame(height: 40)
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
            // withIntermediateDirectories 表示如果路径的中间路径不存在，则创建它
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
    
    private func writeTextToFile() {
        do {
            let textUrl = documentDirectoryUrl.appendingPathComponent("sample.txt")
            try "sample sample sample".write(toFile: textUrl.path, atomically: true, encoding: .utf8)
        } catch {
            print("failed to write text to file")
        }
    }
    
    private func writeImageToFile() {
        do {
            let data = R.image.the_soup()?.jpegData(compressionQuality: 1)
            let url = documentDirectoryUrl.appendingPathComponent("image.jpg")
            try data?.write(to: url)
        } catch {
            print("failed to write image to file")
        }
    }
    
    private func writeDataToFile() {
        let data = "asdadasdsadsa".data(using: .utf8)
        let url = documentDirectoryUrl.appendingPathComponent("data")
        FileManager.default.createFile(atPath: url.path, contents: data)
    }
    
    private func copyFile() {
        do {
            let copyFrom = documentDirectoryUrl.appendingPathComponent("sample.txt")
            let directory = documentDirectoryUrl.appendingPathComponent("test")
            if !FileManager.default.fileExists(atPath: directory.path) {
                try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
            }
            let copyTo = directory.appendingPathComponent("copied_sample.txt")
            if !FileManager.default.fileExists(atPath: copyTo.path) {
                try FileManager.default.copyItem(at: copyFrom, to: copyTo)
            } else {
                print("file exists")
            }
        } catch {
            print("failed to copy file")
        }
    }
    
    private func sampleFileExists() -> Bool {
        let textUrl = documentDirectoryUrl.appendingPathComponent("sample.txt")
        return FileManager.default.fileExists(atPath: textUrl.path)
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
