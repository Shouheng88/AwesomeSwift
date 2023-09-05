//
//  ContentView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/10/31.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @State private var text = ""
    @State private var bold = false
    @State private var italic = false
    @State private var fontSize = 12.0
    
    /// 示例条目控件
    private func sampleIemView(view: any View, name: String) -> some View {
        NavigationLink(destination: {
            AnyView(view)
        }, label: {
            HStack {
                Spacer()
                Text(name).font(.system(size: 20))
                Spacer()
            }.padding(.vertical, 30)
                .background(Rectangle().fill(.green))
                .cornerRadius(5, antialiased: true)
        })
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(SampleData.getSamples()) { group in
                    HStack(spacing: 10) {
                        ForEach(group.items) { item in
                            sampleIemView(view: item.destination, name: item.name)
                        }
                    }
                }.padding(.vertical, 15).padding(.horizontal, 15)
            }
            .toolbar {
                // 工具栏的使用方法，但是需要放到 NavigationView 内部
                ToolbarItemGroup {
                     Slider(
                         value: $fontSize,
                         in: 8...120,
                         minimumValueLabel:
                             Text("A").font(.system(size: 8)),
                         maximumValueLabel:
                             Text("A").font(.system(size: 16))
                     ) {
                         Text("Font Size 15")
                     }
                     .frame(width: 150)
                     Toggle(isOn: $bold) {
                         Image(systemName: "bold")
                     }
                     Toggle(isOn: $italic) {
                         Image(systemName: "italic")
                     }
                }
            }.navigationTitle(Text("Aswsome Swift"))
                .navigationBarTitleDisplayMode(.inline)
                .onReceive(NotificationCenter.Publisher(
                    center: NotificationCenter.default,
                    name: NSNotification.Name(Events.SMAPLE_NOTIFICATION_NAME)
                ), perform: { out in
                    debugPrint("RECEIVED NOTIFICATION WITH \(String(describing: out.object))")
                })
        }.navigationViewStyle(.stack)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
