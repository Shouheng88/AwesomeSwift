//
//  UtlisDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

/// 权限示例
struct PermissionDemoView: View {
    
    private var contactPermissionView: some View {
        VStack {
            Text("联系人权限 \(ContactsPermission.authorizationStatus.rawValue)")
            Button("请求联系人权限", action: {
                ContactsPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var locationPermissionView: some View {
        VStack {
            Text("位置权限: \(LocationPermission.authorizationStatus.rawValue)")
            Button("请求位置权限", action: {
                LocationPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var photoLibraryPermissionView: some View {
        VStack {
            Text("相册权限: \(PhotoLibraryPermission.authorizationStatusText)")
            Button("请求相册权限", action: {
                PhotoLibraryPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var cameraPermissionView: some View {
        VStack {
            Text("相机权限: \(CameraPermission.authorizationStatusText)")
            Button("请求相机权限", action: {
                CameraPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    var body: some View {
        ScrollView{
            VStack {
                contactPermissionView
                locationPermissionView
                photoLibraryPermissionView
                cameraPermissionView
            }.padding(15)
        }.navigationTitle("权限示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct UtlisDemoView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDemoView()
    }
}
