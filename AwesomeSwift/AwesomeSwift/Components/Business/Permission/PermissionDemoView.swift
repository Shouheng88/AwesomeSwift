//
//  UtlisDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct PermissionDemoView: View {
    
    private var permissionSampleView: some View {
        VStack {
            Text("Contact permission status: \(ContactsPermission.authorizationStatus.rawValue)")
            Button("Request Contace Permission", action: {
                ContactsPermission.request()
            }).frame(height: 40)
            Divider()
            Text("Location permission status: \(LocationPermission.authorizationStatus.rawValue)")
            Button("Request Location Permission", action: {
                LocationPermission.request()
            }).frame(height: 40)
            Divider()
        }
    }
    
    var body: some View {
        ScrollView{
            VStack {
                permissionSampleView
                Spacer()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct UtlisDemoView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionDemoView()
    }
}
