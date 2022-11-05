//
//  PullToRefreshViewDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI

struct PullToRefreshViewDemo: View {
    
    @State
    private var isFooterRefreshing: Bool = false
    @State
    private var isHeaderRefreshing: Bool = false
    private var listState = ListState()

    var body: some View {
        ScrollView(content: {
            PullToRefreshView(header: RefreshDefaultHeader(), footer: RefreshDefaultFooter(), content: {
                VStack(content: {
                    Button("Set Header Refresh", action: {
                        self.isHeaderRefreshing = !self.isHeaderRefreshing
                    }).frame(height: 40)
                    Button("Set Footer Refresh", action: {
                        self.isFooterRefreshing = !self.isFooterRefreshing
                    }).frame(height: 40)
                })
            }).environmentObject(listState)
        }).addPullToRefresh(isHeaderRefreshing: self.$isHeaderRefreshing, onHeaderRefresh: {
            print("header refreshing")
        }, isFooterRefreshing: self.$isFooterRefreshing, onFooterRefresh: {
            print("footer refreshing")
        })
    }
}

struct PullToRefreshViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        PullToRefreshViewDemo()
    }
}
