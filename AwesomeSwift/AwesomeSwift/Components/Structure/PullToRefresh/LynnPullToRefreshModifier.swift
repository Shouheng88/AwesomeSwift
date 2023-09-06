//
//  LynnPullToRefreshModifier.swift
//  SwiftUIPullToRefresh
//
//  Created by apple on 2021/7/14.
//

import SwiftUI

extension View {
    func addPullToRefresh(isHeaderRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?) -> some View {
        addPullToRefresh(isHeaderRefreshing: isHeaderRefreshing, onHeaderRefresh: onHeaderRefresh, isFooterRefreshing: nil, onFooterRefresh: nil)
    }
    
    func addPullToRefresh(isFooterRefreshing: Binding<Bool>?, onFooterRefresh: (() -> Void)?) -> some View {
        addPullToRefresh(isHeaderRefreshing: nil, onHeaderRefresh: nil, isFooterRefreshing: isFooterRefreshing, onFooterRefresh: onFooterRefresh)
    }
    
    func addPullToRefresh(isHeaderRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?, isFooterRefreshing: Binding<Bool>?, onFooterRefresh: (() -> Void)?) -> some View {
        modifier(PullToRefreshModifier(isHeaderRefreshing: isHeaderRefreshing, isFooterRefreshing: isFooterRefreshing, onHeaderRefresh: onHeaderRefresh, onFooterRefresh: onFooterRefresh))
    }
}


struct PullToRefreshModifier: ViewModifier {
    @Binding var isHeaderRefreshing: Bool
    @Binding var isFooterRefreshing: Bool
    
    let onHeaderRefresh: (() -> Void)?
    let onFooterRefresh: (() -> Void)?
    
    init(isHeaderRefreshing: Binding<Bool>?, isFooterRefreshing: Binding<Bool>?, onHeaderRefresh: (() -> Void)?, onFooterRefresh: (() -> Void)?) {
        self._isHeaderRefreshing = isHeaderRefreshing ?? .constant(false)
        self._isFooterRefreshing = isFooterRefreshing ?? .constant(false)
        self.onHeaderRefresh = onHeaderRefresh
        self.onFooterRefresh = onFooterRefresh
    }
    
    @State private var headerRefreshData = RefreshData()
    @State private var footerRefreshData = RefreshData()
    
    func body(content: Content) -> some View {
        GeometryReader { proxy in
            content
                .environment(\.headerRefreshData, headerRefreshData)
                .environment(\.footerRefreshData, footerRefreshData)
                .onChange(of: isHeaderRefreshing, perform: { value in
                    if !value {
                        self.headerRefreshData.refreshState = .stopped
                    }
                })
                .onChange(of: isFooterRefreshing, perform: { value in
                    if !value {
                        self.footerRefreshData.refreshState = .stopped
                    }
                })
                // 进入界面 默认刷新
                .onAppear {
                    if(self.headerRefreshData.refreshState == .invalid){
                        self.headerRefreshData.refreshState = .loading
                        self.headerRefreshData.progress = 1.0
                        self.isHeaderRefreshing = true
                        self.onHeaderRefresh?()
                    }
                }
                .backgroundPreferenceValue(HeaderBoundsPreferenceKey.self) { value -> Color in
                    DispatchQueue.main.async {
                        calculateHeaderRefreshState(proxy, value: value)
                    }
                    return Color.clear // 返回一个透明背景，无效果，仅用于在视图更新时触发calculateHeaderRefreshState函数
                }
                .backgroundPreferenceValue(FooterBoundsPreferenceKey.self) { value -> Color in
                    // 接收到以FooterBoundsPreferenceKey标记的Preference，也就是value=[content.bounds, footer.bounds]
                    DispatchQueue.main.async {
                        calculateFooterRefreshState(proxy, value: value)
                    }
                    return Color.clear
                }
        }
    }
}

extension PullToRefreshModifier {
    private func calculateHeaderRefreshState(_ proxy: GeometryProxy, value: [HeaderBoundsPreferenceKey.Item]) {
        guard let bounds = value.first?.bounds else {
            return
        }
        
        // caculate state
        guard headerRefreshData.refreshState != .loading else {
            return
        }
        
        guard isFooterRefreshing != true else {
            return
        }
        
//        print("the bounds is: \(bounds)")
        let headerFrame = proxy[bounds] // we need geometry proxy to get real frame
        
        let y = headerFrame.minY
        let threshold = headerFrame.height
        let topDistance: CGFloat = 30.0
        
        if threshold != headerRefreshData.thresold {
            headerRefreshData.thresold = threshold
        }
        
        if -y == headerRefreshData.thresold && headerFrame.width == proxy.size.width && headerRefreshData.refreshState == .invalid {
            headerRefreshData.refreshState = .stopped
        }
        
        var contentOffset = y + threshold
        
        if contentOffset == 0 {
            headerRefreshData.progress = 0.0
        }
        
        guard contentOffset > topDistance else {
            return
        }
        
        contentOffset -= topDistance
        
//        print("the header frame is: \(headerFrame) and scroll view size: \(proxy.size)")
//        print("content offset is: \(contentOffset)")
        
        
        if contentOffset <= threshold && headerRefreshData.refreshState == .stopped {
            let oldProgress = headerRefreshData.progress
            let progress = Double(contentOffset / threshold)
            if progress < oldProgress {
                return
            }
            headerRefreshData.progress = (progress >= 1.0) ? 1.0 : progress
        }
        
        if contentOffset > threshold && headerRefreshData.refreshState == .stopped && headerRefreshData.refreshState != .triggered {
            headerRefreshData.refreshState = .triggered
            headerRefreshData.progress = 1.0
        }
        
        if contentOffset <= threshold && headerRefreshData.refreshState == .triggered && headerRefreshData.refreshState != .loading {
            headerRefreshData.refreshState = .loading
            headerRefreshData.progress = 1.0
            isHeaderRefreshing = true
            onHeaderRefresh?()
            if(!isHeaderRefreshing){
                // 检查一下避免在onHeaderRefresh中同步的改回了false导致onChange没有触发
                headerRefreshData.refreshState = .stopped
            }
        }
    }
    
    private func calculateFooterRefreshState(_ proxy: GeometryProxy, value: [FooterBoundsPreferenceKey.Item]) {
        // value = [content.bounds, footer.bounds]
        guard let bounds = value.last?.bounds else {
            return
        }
        guard let contentBounds = value.first?.bounds else {
            return
        }
                
        guard footerRefreshData.refreshState != .loading else {
            return
        }
        
        guard isHeaderRefreshing != true else {
            return
        }
        
        let footerFrame = proxy[bounds]
        let contentFrame = proxy[contentBounds]
        
//        let contentTop = contentFrame.minY // 未滚动时为0，滚动后为负值
        let y = footerFrame.minY
        let threshold = footerFrame.height
        let bottomDistance: CGFloat = 30.0
        
        let scrollViewHeight = min(proxy.size.height, contentFrame.height) // 如果满了就以屏幕下边沿计算，如果没填满就以内容下边沿计算
        
        if threshold != footerRefreshData.thresold {
            footerRefreshData.thresold = threshold
        }
        // y == (scrollViewHeight + footerRefreshData.thresold)) 等待初始化完成footer到达原始位置 允许一定的浮点误差
        if abs(y - (scrollViewHeight + footerRefreshData.thresold)) < 0.001 && footerFrame.width == proxy.size.width && footerRefreshData.refreshState == .invalid {
            footerRefreshData.refreshState = .stopped
        }
        
        var contentOffset = scrollViewHeight - y
        
        if contentOffset == 0 {
            footerRefreshData.progress = 0.0
        }
        
        guard contentOffset > bottomDistance else {
            return
        }
        
        contentOffset -= bottomDistance
        
//        print("the footer frame is: \(footerFrame) | \(contentFrame) and scroll view size: \(proxy.size)")
//        print("content offset is: \(contentOffset) / \(threshold)")
        
        if contentOffset <= threshold && footerRefreshData.refreshState == .stopped {
//            let oldProgress = footerRefreshData.progress
            let progress = Double(contentOffset / threshold)
//            if progress < oldProgress {
//                return
//            }
            footerRefreshData.progress = (progress >= 1.0) ? 1.0 : progress
        }
        
        if contentOffset > threshold && footerRefreshData.refreshState == .stopped && footerRefreshData.refreshState != .triggered {
            // 进入预备刷新状态，条件
            // 1. 滚动到下方空白大于threshold(=footer的高度)
            // 2. 当前有滚动、不在初始状态
            // 3. 当前没在刷新（==.stopped）
            footerRefreshData.refreshState = .triggered
            footerRefreshData.progress = 1.0
        }
        
        if contentOffset <= threshold && footerRefreshData.refreshState == .triggered && footerRefreshData.refreshState != .loading {
            // 正式开始刷新，条件
            // 1. 当前在预备刷新状态（==.triggered）
            // 2. 回弹到下方空白小于threshold(=footer的高度)/或者在没滚动状态（也就是因为list太短没法滚动）
            footerRefreshData.refreshState = .loading
            footerRefreshData.progress = 0.0
            isFooterRefreshing = true
            onFooterRefresh?()
            if(!isFooterRefreshing){
                // 检查一下避免在onFooterRefresh中同步的改回了false导致onChange没有触发
                footerRefreshData.refreshState = .stopped
            }
        }
    }
}
