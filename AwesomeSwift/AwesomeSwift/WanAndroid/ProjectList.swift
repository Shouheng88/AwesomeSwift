//
//  WanAndroid.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/1.
//

import SwiftUI
import Rswift

struct ProjectList: View {
    
    @ObservedObject
    private var viewModel: ProjectViewModel = ProjectViewModel()
    @State
    private var scrollToTop: Int = 0
    private let scrollAreaId = "scrollArea"
    @State private var scrollWidth: CGFloat? = 0
    @State private var scrollOffset: CGFloat? = 0

    private var loadingMoreView: some View {
        Text(NSLocalizedString("wna_android_pull_to_load", comment: ""))
            .onAppear(perform: {
                viewModel.request()
            })
    }
    
    private var projectListView: some View {
        ZStack {
            ScrollViewReader(content: { proxy in
                ScrollView {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .named(scrollAreaId))
                        let offset = frame.minY
                        let width = frame.width
                        Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                        Color.clear.preference(key: WidthPreferenceKey.self, value: width)
                    }
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.projects) { project in
                            NavigationLink(destination: {
                                WebView(url: project.link ?? "")
                                    .navigationTitle(project.title ?? "")
                            }, label: {
                                ProjectRow(project: project)
                            }).id(project.id)
                            let index = viewModel.projects.firstIndex(of: project)
                            if index != viewModel.projects.count - 1 {
                                Divider()
                            }
                        }
                        if viewModel.projects.count > 0 {
                            loadingMoreView
                        }
                    }.onChange(of: scrollToTop, perform: { newValue in
                        proxy.scrollTo(viewModel.projects.first?.id)
                    })
                // 属性监听要放到这里才行，放到 scrollview 内部监听不到 ...
                }.onPreferenceChange(WidthPreferenceKey.self) { value in
                    self.scrollWidth = value
                }
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    DispatchQueue.main.async {
                        self.scrollOffset = value
                    }
                }
            })
            bottomRightFab
            scrollInfoView
        }.onAppear(perform: {
            viewModel.request()
        }).navigationTitle(R.string.localizable.wan_android())
    }
    
    private var bottomRightFab: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.scrollToTop = self.scrollToTop + 1
                }, label: {
                    Image(systemName: "arrow.up.circle")
                        .resizable()
                        .padding(10)
                        .frame(width: 50, height: 50)
                        .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                        .shadow(radius: 0)
                }).shadow(color: .gray, radius: 2, x: 0, y: 3)
            }.padding(.trailing, 8)
        }
    }
    
    private var scrollInfoView: some View {
        VStack {
            HStack {
                Spacer()
                Text("Scroll info:\nwidth[\(self.scrollWidth ?? 0)]\noffset[\(self.scrollOffset ?? 0)]")
                    .padding(10)
                    .background(Rectangle().fill(.white))
            }
            Spacer()
        }
    }
    
    private var loadingView: some View {
        Text(NSLocalizedString("wna_android_loading", comment: ""))
    }

    private var emptyView: some View {
        Text(R.string.localizable.wna_android_empty_title())
    }
    
    var body: some View {
        ZStack {
            if viewModel.projects.count == 0 {
                if viewModel.state == ProjectViewModel.STATE_LOAD_FINISHED {
                    emptyView
                } else if viewModel.state == ProjectViewModel.STATE_LOADING {
                    loadingView
                }
            }
            projectListView
        }
    }
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat? = nil
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue() ?? value
    }
}

struct WanAndroid_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}
