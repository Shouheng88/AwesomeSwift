//
//  TabDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct TabDemoView: View {
    
    @State var selection: Int = 0
    @State var tip: String = ""
    
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                ForEach(0..<5) { idx in
                    VStack {
                        if idx == 0 {
                            SlidePageView()
                        } else {
                            NormalPageView(idx: idx)
                        }
                    }.tabItem {
                        VStack {
                            Text("Tab \(idx+1)").onTapGesture {
                                self.tip = "you cliked the tab of index [\(selection)]"
                            }
                            Image(systemName: "trash")
                        }.onTapGesture {
                            self.tip = "you cliked the tab"
                        }
                    }
                }
            }
            Text(self.tip)
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }.navigationBarHidden(selection == 4)
            .navigationBarTitle("TAB Title \(selection + 1)", displayMode: .inline)
            .navigationBarItems(trailing: trailingView)
    }
    
    private var trailingView: some View {
        switch selection {
        case 0:
            return AnyView(Image(systemName: "plus.circle"))
        case 1:
            return AnyView(Image(systemName: "person.badge.plus"))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct SlidePageView: View {

    private let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple, .brown]
    @State var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack {
                    Text("Slide Page [\(idx)]")
                    Button("Click to Navigate to Next Page", action: {
                        let next = self.selection + 1
                        if next >= 8 {
                            self.selection = 0
                        } else {
                            self.selection = next
                        }
                    }).frame(height: 40).foregroundColor(.white)
                }.frame(width: UIScreen.main.bounds.width, height: 200)
                    .background(colors[idx])
                    .tabItem{
                        Image(uiImage: R.image.heart_lock()!)
//                            .foregroundColor(.green)
//                            .cornerRadius(10)
//                            .font(.system(size: 5))
//                            .frame(width: 10, height: 10)
                    }
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)).background(.pink)
    }
}

struct NormalPageView: View {
    
    let idx: Int
    private let colors: [Color] = [.red, .green, .blue, .orange, .yellow]

    var body: some View {
        VStack {
            ScrollView(content: {
                VStack{
                    Text(
                        "This is the page for tab item with index [\(idx)]. This might be a good practice to show how the TabView of SwiftUI works! If you have any question, you can contace me at email blablabla@gmail.com anytime."
                    ).padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                    .frame(width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height)
                        .background(colors[idx])
                }
            })
            Spacer()
            Divider()
        }
    }
}

struct TabDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TabDemoView()
    }
}
