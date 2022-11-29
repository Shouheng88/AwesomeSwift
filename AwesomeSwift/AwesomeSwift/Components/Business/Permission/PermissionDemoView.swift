//
//  UtlisDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct PermissionDemoView: View {
    
    private var contactPermissionView: some View {
        VStack {
            Text("Contact permission status: \(ContactsPermission.authorizationStatus.rawValue)")
            Button("Request Contace Permission", action: {
                ContactsPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var locationPermissionView: some View {
        VStack {
            Text("Location permission status: \(LocationPermission.authorizationStatus.rawValue)")
            Button("Request Location Permission", action: {
                LocationPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var photoLibraryPermissionView: some View {
        VStack {
            Text("Photo library permission status: \(PhotoLibraryPermission.authorizationStatusText)")
            Button("Request Photo Library Permission", action: {
                PhotoLibraryPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    private var cameraPermissionView: some View {
        VStack {
            Text("Camera permission status: \(CameraPermission.authorizationStatusText)")
            Button("Request Camera Permission", action: {
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
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct UtlisDemoView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDemoView()
    }
}
