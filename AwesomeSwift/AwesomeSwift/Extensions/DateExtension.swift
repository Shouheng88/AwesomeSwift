//
//  DateExtension.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/3.
//

import Foundation

extension Date {
    func format(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate(format)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
}
