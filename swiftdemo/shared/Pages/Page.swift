//
//  Page.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/10.
//

import Foundation
import SwiftUI

struct SampleView: View {
    
    var title: String = ""
    var subTitle: String = ""
    
    var body: some View {
        HStack {
            VStack {
                Text(title)
                Text(subTitle)
            }
            Spacer()
            Text("Foot")
        }
    }
}

struct SampleView_Previews: PreviewProvider {
    
    static var previews: some View {
        SampleView(title: "Hello ,", subTitle: "World !!").frame(width: 300, height: 300, alignment: .center)
    }
}

