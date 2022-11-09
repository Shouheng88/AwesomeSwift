//
//  CustomPreference.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/9.
//

import Foundation
import SwiftUI

struct CustomPreferenceKey: PreferenceKey {
    
    static var defaultValue: CGPoint = CGPoint()

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
      value = nextValue()
    }
}

extension View {
    func customPreference(_ value: CGPoint) -> some View {
        self.preference(key: CustomPreferenceKey.self, value: value)
    }
}
