//
//  TabDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

/// 底部导航栏示例
struct BottomTabDemoView: View {
    
    @State var selection: Int = 0
    @State var tip: String = ""
    
    var body: some View {
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
            .navigationBarTitle("顶部导航栏示例 \(selection + 1)", displayMode: .inline)
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

    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1), .orange.opacity(0.1),
        .yellow.opacity(0.1), .pink.opacity(0.1), .purple.opacity(0.1), .black.opacity(0.1)]
    @State var selection: Int = 0

    private var customIndicatorView: some View {
        HStack(spacing: 15) {
            ForEach(0..<8) { idx in
                Rectangle()
                    .fill(.black.opacity(selection == idx ? 1 : 0.5))
                    .frame(width: 8, height: 8, alignment: .center)
            }
        }.padding(.bottom, 20)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack(spacing: 15) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("可滑动页面 [\(idx)]")
                        Spacer()
                    }
                    Button("跳转到下一个页面", action: {
                        let next = self.selection + 1
                        if next >= 8 {
                            self.selection = 0
                        } else {
                            self.selection = next
                        }
                    })
                    Spacer()
                }.background(colors[idx])
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .overlay(customIndicatorView, alignment: .bottom)
    }
}

struct SlidePageView: View {

    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1),
        .orange.opacity(0.1), .yellow.opacity(0.1), .pink.opacity(0.1), .purple.opacity(0.1), .black.opacity(0.1)]
    @State var selection: Int = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(0..<8) { idx in
                VStack(spacing: 15) {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("可滑动页面 [\(idx)]")
                        Spacer()
                    }
                    Button("跳转到下一个页面", action: {
                        let next = self.selection + 1
                        if next >= 8 {
                            self.selection = 0
                        } else {
                            self.selection = next
                        }
                    })
                    Spacer()
                }.background(colors[idx])
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    }
}

struct NormalPageView: View {
    
    let idx: Int
    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1), .orange.opacity(0.1), .yellow.opacity(0.1)]

    var body: some View {
        VStack{
            Spacer()
            HStack {
                Spacer()
                Text("TAB 页面 [\(idx)]")
                Spacer()
            }
            Spacer()
        }.background(colors[idx])
    }
}

struct TabDemoView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabDemoView()
    }
}
