//
//  AppInfoDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI

struct AppInfoDemoView: View {
    var body: some View {
        VStack {
            VStack {
                Text("App Name: \(AppInfoUtils.appName)")
                Text("App Version: \(AppInfoUtils.appVersion)")
                Text("App Build: \(AppInfoUtils.appBuild)")
                Text("App Build Date: \(AppInfoUtils.getDateString(date: AppInfoUtils.buildDate))")
            }.padding(.top, 10)
        }
    }
}

struct AppInfoDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoDemoView()
    }
}
