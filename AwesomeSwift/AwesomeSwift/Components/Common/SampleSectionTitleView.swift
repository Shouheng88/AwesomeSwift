//
//  SampleSectionTitleView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2023/9/5.
//

import SwiftUI

struct SampleSectionTitleView: View {
    
    var title: String = ""
    
    var desc: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title).font(.system(size: 16)).foregroundColor(.black)
                Text(desc).font(.system(size: 14)).foregroundColor(.gray)
            }
            Spacer()
        }.padding(.vertical, 10)
    }
}

struct SampleSectionTitleView_Previews: PreviewProvider {
    static var previews: some View {
        SampleSectionTitleView(title: "helloooooo", desc: "world")
    }
}
