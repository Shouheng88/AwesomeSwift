//
//  ChangeIconDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/25.
//

import SwiftUI

/// 修改应用图标
struct ChangeIconDemoView: View {

    private let iconName = UIApplication.shared.alternateIconName ?? ""

    var body: some View {
        VStack {
            Text("当前应用名称: \(iconName)")
            
            Button("清理应用图标", action: {
                UIApplication.shared.setAlternateIconName(nil)
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)
            
            Button("修改应用图标为 Calendar", action: {
                changeToCalendarAppIcon()
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)
            
            Button("修改应用图标为 Swift", action: {
                changeToSwiftAppIcon()
            }).frame(height: 40)
                .disabled(!UIApplication.shared.supportsAlternateIcons)
        }.navigationTitle("修改应用图标").navigationBarTitleDisplayMode(.inline)
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
