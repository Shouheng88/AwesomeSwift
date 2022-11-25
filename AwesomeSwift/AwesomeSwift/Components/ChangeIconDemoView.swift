//
//  ChangeIconDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/25.
//

import SwiftUI

struct ChangeIconDemoView: View {

    private let iconName = UIApplication.shared.alternateIconName ?? ""

    var body: some View {
        VStack {
            Text("Icon name: \(iconName)")
            
            Button("Clear App Icon", action: {
                UIApplication.shared.setAlternateIconName(nil)
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)
            
            Button("Change to Calendar App Icon", action: {
                changeToCalendarAppIcon()
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)
            
            Button("Change to Swift App Icon", action: {
                changeToSwiftAppIcon()
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)

        }
    }
    
    private func changeToCalendarAppIcon() {
        // 修改图标需要在 plist 中添加一些配置
        UIApplication.shared.setAlternateIconName("Calendar", completionHandler: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        })
    }
    
    private func changeToSwiftAppIcon() {
        UIApplication.shared.setAlternateIconName("Swift", completionHandler: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Success!")
            }
        })
    }
}

struct ChangeIconDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeIconDemoView()
    }
}
