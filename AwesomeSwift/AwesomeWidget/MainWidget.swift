//
//  MainWidget.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/26.
//

import Foundation
import WidgetKit
import SwiftUI
import Intents

// 文件归属：点击文件，编辑器右侧，Target Membership
struct AwesomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        AwesomeWidget()
    }
}

struct ClcokWidgetBundle: WidgetBundle {
    var body: some Widget {
        ClockWidget()
    }
}

// 入口函数
@main
struct MainAwesomeWidgetBundle: WidgetBundle {
    var body: some Widget {
        // 支持添加多个 Widget，每个一组，好像一组是三个，最多5组
        AwesomeWidgetBundle().body
        ClcokWidgetBundle().body
        CountdownWidget()
        TimerWidget()
    }
}
