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
        // Use ZStack instead of NavigationView, since NavigationView will
        // put a fade shader on page on 14.x.
//        NavigationView {
        ZStack {
            TabView(selection: $selection) {
                ForEach(0..<5) { idx in
                    VStack {
                        getTabView(idx: idx)
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
            .statusBar(hidden: selection == 4) // hide status bar
    }
    
    private func getTabView(idx: Int) -> some View {
        return VStack {
            if idx == 0 {
                SlidePageView()
            } else if idx == 1 {
                SlidePageViewWithCustomIndicator()
            } else {
                NormalPageView(idx: idx)
            }
        }
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

struct SlidePageViewWithCustomIndicator: View {

    private let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple, .black]
    @State var selection: Int = 0

    var customIndicatorView: some View {
        HStack(spacing: 15) {
            ForEach(0..<8) { idx in
                Rectangle()
                    .fill(.white.opacity(selection == idx ? 1 : 0.5))
                    .frame(width: 5, height: 5, alignment: .center)
            }
        }
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack {
                    Text("Slide Page [\(idx)]").foregroundColor(.white)
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
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .background(Rectangle().fill(.pink))
            .overlay(customIndicatorView, alignment: .bottom)
    }
}

struct SlidePageView: View {

    private let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .pink, .purple, .black]
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
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
//            .background(.pink) // Available only on 15.0 or newer
            .background(Rectangle().fill(.pink))
    }
}

struct NormalPageView: View {
    
    let idx: Int
    private let colors: [Color] = [.red, .green, .blue, .orange, .yellow]

    var body: some View {
        ZStack {
            VStack {
                Color(.gray).frame(height: 300)
                Spacer()
                Color(.gray).frame(height: 300)
            }
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
//                Spacer()
//                Divider()
            }
        }
    }
}

struct TabDemoView_Previews: PreviewProvider {
    static var previews: some View {
        TabDemoView()
    }
}
