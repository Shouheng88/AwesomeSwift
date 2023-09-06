//
//  LynnRefreshState.swift
//  SwiftUIPullToRefresh
//
//  Created by apple on 2021/7/15.
//

import SwiftUI

// MARK: - Preferences

struct HeaderBoundsPreferenceKey: PreferenceKey {
    struct Item {
        let bounds: Anchor<CGRect>
    }
    static var defaultValue: [Item] = []
    
    // 每次有新的init(bounds)就加入value数组
    static func reduce(value: inout [Item], nextValue: () -> [Item]) {
        value.append(contentsOf: nextValue())
    }
}

struct FooterBoundsPreferenceKey: PreferenceKey {
    struct Item {
        let bounds: Anchor<CGRect>
    }
    static var defaultValue: [Item] = []
    
    static func reduce(value: inout [Item], nextValue: () -> [Item]) {
        value.append(contentsOf: nextValue())
    }
}

// MARK: - Environment

struct HeaderRefreshDataKey: EnvironmentKey {
    static var defaultValue: RefreshData = .init()
}

struct FooterRefreshDataKey: EnvironmentKey {
    static var defaultValue: RefreshData = .init()
}

extension EnvironmentValues {
    var headerRefreshData: RefreshData {
        get { self[HeaderRefreshDataKey.self] }
        set { self[HeaderRefreshDataKey.self] = newValue }
    }
    
    var footerRefreshData: RefreshData {
        get { self[FooterRefreshDataKey.self] }
        set { self[FooterRefreshDataKey.self] = newValue }
    }
}

// MARK: - Refresh State Data

enum RefreshState: Int {
    case invalid // 无效
    case stopped // 停止
    case triggered // 触发
    case loading // 加载
}

struct RefreshData {
    var thresold: CGFloat = 0
    var progress: Double = 0
    var refreshState: RefreshState = .invalid
}
