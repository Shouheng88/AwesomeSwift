//
//  LynnPullToRefresh.swift
//  SwiftUIPullToRefresh
//
//  Created by apple on 2021/7/14.
//

import SwiftUI

struct PullToRefreshView<Header, Content, Footer> {
    private let header: Header
    private let footer: Footer
    
    private let content: () -> Content
    
    @Environment(\.headerRefreshData) private var headerRefreshData
    @Environment(\.footerRefreshData) private var footerRefreshData
}

extension PullToRefreshView: View where Header: View, Content: View, Footer: View {
    
    init(header: Header, footer: Footer, @ViewBuilder content: @escaping () -> Content) {
        self.header = header
        self.footer = footer
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 0) {
            header
                .opacity(dynamicHeaderOpacity)
                .frame(maxWidth: .infinity)
                .anchorPreference(key: HeaderBoundsPreferenceKey.self, value: .bounds, transform: {
                    [.init(bounds: $0)]
                }) // 把header的bounds加入已HeaderBoundsPreferenceKey标记的Preference中
            content()
                .anchorPreference(key: FooterBoundsPreferenceKey.self, value: .bounds, transform: {
                    [.init(bounds: $0)]
                }) // 把content的bounds加入已FooterBoundsPreferenceKey标记的Preference中
            footer
                .opacity(dynamicFooterOpacity)
                .frame(maxWidth: .infinity)
                .anchorPreference(key: FooterBoundsPreferenceKey.self, value: .bounds, transform: {
                    [.init(bounds: $0)]
                }) // 把footer的frame加入已FooterBoundsPreferenceKey标记的Preference中
            // 上面content和footer的bounds都加入了FooterBoundsPreferenceKey，此时FooterBoundsPreferenceKey的value是一个有两个元素的数组：[content.bounds, footer.bounds]
        }
        .padding(.top, dynamicHeaderPadding)
        .padding(.bottom, dynamicFooterPadding)
    }
    
    var dynamicHeaderOpacity: Double {
        if headerRefreshData.refreshState == .invalid {
            return 0.0
        }
        if headerRefreshData.refreshState == .stopped {
            return headerRefreshData.progress
        }
        return 1.0
    }
    
    var dynamicFooterOpacity: Double {
        if footerRefreshData.refreshState == .invalid {
            return 0.0
        }
        if footerRefreshData.refreshState == .stopped {
            // progresss = 0: 还没开始拉；progress -> 1 越接近松手加载位置progress越接近1
//            return footerRefreshData.progress == 0 ? 1.0 : footerRefreshData.progress
            return footerRefreshData.progress
        }
        return 1.0
    }
    
    var dynamicHeaderPadding: CGFloat {
        return (headerRefreshData.refreshState == .loading) ? 0.0 : -headerRefreshData.thresold
    }
    
    var dynamicFooterPadding: CGFloat {
        return (footerRefreshData.refreshState == .loading) ? 0.0 : -footerRefreshData.thresold
    }
}

extension PullToRefreshView where Header: View, Content: View, Footer == EmptyView {
    init(header: Header, @ViewBuilder content: @escaping () -> Content) {
        self.init(header: header, footer: EmptyView(), content: content)
    }
}

extension PullToRefreshView where Header == EmptyView, Content: View, Footer: View {
    init(footer: Footer, @ViewBuilder content: @escaping () -> Content) {
        self.init(header: EmptyView(), footer: footer, content: content)
    }
}

extension PullToRefreshView where Header == RefreshDefaultHeader, Content: View, Footer == RefreshDefaultFooter {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.init(header: RefreshDefaultHeader(), footer: RefreshDefaultFooter(), content: content)
    }
}
