//
//  StatusBarStyleEnvironment.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import Foundation


import SwiftUI

extension EnvironmentValues {
    
    var statusBarStyle: StatusBarStyle { self[StatusBarStyle.Key.self] }
}

class StatusBarStyle {
    
    var getter: () -> UIStatusBarStyle = { .default }
    var setter: (UIStatusBarStyle) -> Void = { _ in }

    var current: UIStatusBarStyle {
        get { self.getter() }
        set { self.setter(newValue) }
    }
}

extension StatusBarStyle {
    
    struct Key: EnvironmentKey {
        static let defaultValue: StatusBarStyle = StatusBarStyle()
    }
}

