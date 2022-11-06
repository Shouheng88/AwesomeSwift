//
//  AwesomeSwiftApp.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/10/31.
//

import SwiftUI
import Rswift

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
            
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    
    private func setupStatusBar() {
        guard
            let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
            let statusBarManager = window.windowScene?.statusBarManager else {
            return
        }
//        statusBarManager.statusBarStyle = UIStatusBarStyle.default
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
}
