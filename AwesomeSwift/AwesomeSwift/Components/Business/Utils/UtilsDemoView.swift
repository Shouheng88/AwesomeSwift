//
//  UtlisDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct UtilsDemoView: View {
    
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
    
    private var appInfoSampleView: some View {
        VStack {
            Text("App Name: \(AppInfoUtils.appName)")
            Text("App Version: \(AppInfoUtils.appVersion)")
            Text("App Build: \(AppInfoUtils.appBuild)")
            Text("App Build Date: \(AppInfoUtils.getDateString(date: AppInfoUtils.buildDate))")
            Divider()
        }.padding(.top, 10)
    }
    
    var body: some View {
        ScrollView{
            VStack {
                permissionSampleView
                appInfoSampleView
                Spacer()
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct UtlisDemoView_Previews: PreviewProvider {
    static var previews: some View {
        UtilsDemoView()
    }
}
