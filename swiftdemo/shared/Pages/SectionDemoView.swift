//
//  SectionDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

final class SectionDemoViewModel: ObservableObject {
    @Published var sources: [String] = []
    var currentIndex = 0
}

struct SectionDemoView: View {

    @ObservedObject var viewModel: SectionDemoViewModel

    var body: some View {
        VStack {
            Section(header: Text("Here is a header"), footer: Text("Here is a footer")) {
                List(viewModel.sources, id: \.self) { word in
                    Text(word)
                }.listStyle(GroupedListStyle())
            }
         
            Button(action: {
                viewModel.currentIndex += 1
                viewModel.sources.append("Added new item \(viewModel.currentIndex)....")
            }, label: {
                Text("添加一个")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30, height: 40)
            }).background(Color.orange).cornerRadius(8)

            /// 这里的button怎么就默认在最底部了??
            Button(action: {
                print("呵呵")
            }, label: {
                Text("Button is Here!!")
                    .bold()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.main.bounds.width-30, height: 40)
            }).background(Color.orange).cornerRadius(8)
        }.onAppear {
            for index in 0..<20 {
                viewModel.currentIndex = index
                viewModel.sources.append("I'm a list item. My name is \(index)")
            }
        }
    }
}

struct SectionDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SectionDemoView(viewModel: SectionDemoViewModel())
    }
}
