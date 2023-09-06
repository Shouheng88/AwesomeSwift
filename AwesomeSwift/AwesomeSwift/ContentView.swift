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
                Text(name).font(.system(size: 18))
                Spacer()
            }.frame(height: 100)
                .background(Rectangle().fill(.gray.opacity(0.1)))
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
            .navigationTitle(Text("Aswsome Swift"))
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
