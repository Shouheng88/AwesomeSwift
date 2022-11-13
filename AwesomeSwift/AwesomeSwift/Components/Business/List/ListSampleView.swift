//
//  ListSampleView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct ListSampleView: View {
    var body: some View {
        VStack {
            NavigationLink{
                OptionListView()
            } label: {
                Text("Option List")
            }.frame(height: 40)
            
            NavigationLink{
                SectionListView()
            } label: {
                Text("Section List")
            }.frame(height: 40)
            
            NavigationLink{
                SwipeListView()
            } label: {
                Text("Swipe List")
            }.frame(height: 40)
        }.navigationBarTitleDisplayMode(.inline)
    }
}

struct ListSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ListSampleView()
    }
}
