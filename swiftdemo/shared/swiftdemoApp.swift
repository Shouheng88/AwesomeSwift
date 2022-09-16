//
//  swiftdemoApp.swift
//  Shared
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI

// TODO 注解的作用是什么？
@main
struct swiftdemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // .environment 是什么意思？？
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
