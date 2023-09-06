//
//  ListSampleView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

/// 列表示例
struct ListSampleView: View {
    var body: some View {
        VStack {
            NavigationLink{
                OptionListView()
            } label: {
                Text("删除和拖动列表")
            }.frame(height: 40)
            
            NavigationLink{
                SectionListView()
            } label: {
                Text("分组列表示例")
            }.frame(height: 40)
            
            NavigationLink{
                SwipeListView()
            } label: {
                Text("侧滑列表示例")
            }.frame(height: 40)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct ListSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListSampleView()
    }
}
