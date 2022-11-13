//
//  AppInfoUtils.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import Foundation

struct AppInfoUtils {
    
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
    
    private static var infoAttr: [FileAttributeKey : Any]? {
       guard let infoPath = Bundle.main.path(forResource: "Info.plist", ofType: nil) else {
           return nil
       }
       guard let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath) else {
           return nil
       }
       return infoAttr
    }

    static var buildDate: Date? {
        let key = FileAttributeKey(rawValue: "NSFileCreationDate")
        guard let infoDate = infoAttr?[key] as? Date else {
            return nil
        }
        return infoDate
    }
    
    static func getDateString(date: Date?) -> String {
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
