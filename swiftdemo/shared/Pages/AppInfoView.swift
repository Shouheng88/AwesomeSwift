//
//  AppInfoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/10/10.
//

import SwiftUI

struct AppInfoView: View {
    
    private static var infoAttr: [FileAttributeKey : Any]? {
        guard let infoPath = Bundle.main.path(forResource: "Info.plist", ofType: nil) else {
            return nil
        }
        guard let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath) else {
            return nil
        }
        return infoAttr
    }
    
    private static var buildDate: Date? {
       let key = FileAttributeKey(rawValue: "NSFileCreationDate")
       guard let infoDate = infoAttr?[key] as? Date else {
           return nil
       }
       return infoDate
    }
    
    static var appName: String {
        let mainBundle = Bundle.main
        let string0 = mainBundle.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
        let string1 = mainBundle.object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
        let string = string0 ?? string1 ?? ""
        return string
    }

    static var appVersion: String {
        let mainBundle = Bundle.main
        let string0 = mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let string = string0 ?? ""
        return string
    }

    static var appBuild: String {
        let mainBundle = Bundle.main
        let string0 = mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
        let string = string0 ?? ""
        return string
    }
    
    var body: some View {
        VStack {
            Group{
                Text("Build Date: " + getDateString(date: AppInfoView.buildDate))
                Text("App Name: \(AppInfoView.appName)")
                Text("App Version: \(AppInfoView.appVersion)")
                Text("App Build: \(AppInfoView.appBuild)")
            }
            Group {
                Text("Contact permission: \(ContactsPermission.authorizationStatus.rawValue)")
                    .onTapGesture {
                        ContactsPermission.request()
                    }
                Text("Location permission: \(LocationPermission.authorizationStatus.rawValue)")
                    .onTapGesture {
                        LocationPermission.request()
                    }
            }
        }
    }
    
    private func getDateString(date: Date?) -> String {
        guard date != nil else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd HH:mm:ss ZZZ")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: date!)
    }
}

struct AppInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoView()
    }
}
