//
//  swiftdemoApp.swift
//  Shared
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI

fileprivate var shortcutItemToProcess: UIApplicationShortcutItem?

@main
struct swiftdemoApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @Environment(\.scenePhase) var phase
    
    @Environment(\.truncationMode) var truncationMode

    @StateObject private var store = SharedStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                // 相当于指定了 environment
                .environment(\.truncationMode, .head)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
                // TODO: 这个怎么用？？
                // 收到指定类型的 activity 的时候调用
                .onContinueUserActivity("envent_haha") { NSUserActivity in
                    print("Continue activity")
                }
        }.onChange(of: phase) { phase in
            switch phase {
                // 冷启动后台进入前台：active
                // 非冷启动后台进入前台：inactive, active
                // 前台进入后台：inactive background
            case .active:
                print("phase [active]")

                guard let name = shortcutItemToProcess?.userInfo?["me.shouheng.quick_action_key"] as? String else { return }
                
                do { shortcutItemToProcess = nil }
            
                switch name {
                case "me.shouheng.quick_action":
                    print("CLICKEd QUICK ACTION !!")
                case "me.shouheng.quick_action_2":
                    print("CLICKEd QUICK ACTION2 !!")
                default:
                    break
                }
            case .inactive: print("phase [inactive]")
            case .background:
                print("phase [background]")
                addQuickActions()
            default: print("phase [default]")
            }
        }.commands {
            // TODO: 添加命令？命令用来干什么的？
        }
    }
    
    private func addQuickActions() {
        UIApplication.shared.shortcutItems = [
            UIApplicationShortcutItem(
                type: "me.shouheng.quick_action",
                localizedTitle: "Quick Action",
                localizedSubtitle: "Quick action subtitle",
                icon: UIApplicationShortcutIcon(type: .compose),
                userInfo: ["me.shouheng.quick_action_key" : "me.shouheng.quick_action" as NSSecureCoding]
            ),
            UIApplicationShortcutItem(
                type: "me.shouheng.quick_action_2",
                localizedTitle: "Quick Action 2",
                localizedSubtitle: "Quick action subtitle 2",
                icon: UIApplicationShortcutIcon(type: .date),
                userInfo: ["me.shouheng.quick_action_key" : "me.shouheng.quick_action_2" as NSSecureCoding]
            )
        ]
    }
}

// 由于目前还是测试版，虽然很多的事件已经定义，但现在并没有响应：简直草泥马🦙
class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("application")
        return true
    }
    
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        print("application 3")
        
        if let shortcutItem = options.shortcutItem {
            shortcutItemToProcess = shortcutItem
        }
        
        let scenceConfiguration = UISceneConfiguration(name: "Custom configuration", sessionRole: connectingSceneSession.role)
        scenceConfiguration.delegateClass = CustomSceneDelegrate.self
        return scenceConfiguration
    }
    
    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        print("application 2")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("applicationWillResignActive")
    }
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        print("applicationDidFinishLaunching")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
    
    func applicationSignificantTimeChange(_ application: UIApplication) {
        print("applicationSignificantTimeChange")
    }
}

class CustomSceneDelegrate: UIResponder, UIWindowSceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("CustomSceneDelegrate_windowScene")
        shortcutItemToProcess = shortcutItem
    }
}
