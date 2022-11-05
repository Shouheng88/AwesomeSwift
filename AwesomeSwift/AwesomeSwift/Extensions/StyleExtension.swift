//
//  Style.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/10/31.
//

import Foundation
import SwiftUI

struct TitleTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack {
            Divider()
            content
                .font(.system(size: 20))
                .padding(5)
                .foregroundColor(Color.red)
        }
    }
}

extension View {
    func sectionTitle() -> some View {
        self.modifier(TitleTextStyle())
    }
}
