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
                // ???????????? ????????????
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
                    return Color.clear // ????????????????????????????????????????????????????????????????????????calculateHeaderRefreshState??????
                }
                .backgroundPreferenceValue(FooterBoundsPreferenceKey.self) { value -> Color in
                    // ????????????FooterBoundsPreferenceKey?????????Preference????????????value=[content.bounds, footer.bounds]
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
                // ?????????????????????onHeaderRefresh?????????????????????false??????onChange????????????
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
        
//        let contentTop = contentFrame.minY // ???????????????0?????????????????????
        let y = footerFrame.minY
        let threshold = footerFrame.height
        let bottomDistance: CGFloat = 30.0
        
        let scrollViewHeight = min(proxy.size.height, contentFrame.height) // ????????????????????????????????????????????????????????????????????????????????????
        
        if threshold != footerRefreshData.thresold {
            footerRefreshData.thresold = threshold
        }
        // y == (scrollViewHeight + footerRefreshData.thresold)) ?????????????????????footer?????????????????? ???????????????????????????
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
            // ?????????????????????????????????
            // 1. ???????????????????????????threshold(=footer?????????)
            // 2. ????????????????????????????????????
            // 3. ?????????????????????==.stopped???
            footerRefreshData.refreshState = .triggered
            footerRefreshData.progress = 1.0
        }
        
        if contentOffset <= threshold && footerRefreshData.refreshState == .triggered && footerRefreshData.refreshState != .loading {
            // ???????????????????????????
            // 1. ??????????????????????????????==.triggered???
            // 2. ???????????????????????????threshold(=footer?????????)/??????????????????????????????????????????list?????????????????????
            footerRefreshData.refreshState = .loading
            footerRefreshData.progress = 0.0
            isFooterRefreshing = true
            onFooterRefresh?()
            if(!isFooterRefreshing){
                // ?????????????????????onFooterRefresh?????????????????????false??????onChange????????????
                footerRefreshData.refreshState = .stopped
            }
        }
    }
}
