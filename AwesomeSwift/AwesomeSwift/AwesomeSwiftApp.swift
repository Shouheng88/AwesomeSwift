//
//  AwesomeSwiftApp.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/10/31.
//

import SwiftUI
import Rswift

// TODO: 文件读写
// TODO: 异常捕获
// TODO: 图片选择
// TODO: 文件选择
// TODO: 相机
// TODO: 视频
// TODO: 音频
// TODO: iCloud
// TODO: WebDAV
// TODO: 付费、购买
// TODO: 路由体系

@main
struct AwesomeSwiftApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: setupNavigationBar)
                .onAppear(perform: setupStatusBar)
        }
    }
    
    private func setupNavigationBar() {
        // Global configuration for navigation bar
        UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .green
        UINavigationBar.appearance().barTintColor = .green

        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            
            // 避免 iOS15 增加的列表顶部空白
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    private func setupStatusBar() {
        guard
            let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
            let statusBarManager = window.windowScene?.statusBarManager
        else { return }
        StatusBarStyle.Key.defaultValue.getter = {
            statusBarManager.statusBarStyle
        }
        StatusBarStyle.Key.defaultValue.setter = {
            /// 暂时还没有找到更好的方法
            UIApplication.shared.statusBarStyle = $0
        }
    }
}
