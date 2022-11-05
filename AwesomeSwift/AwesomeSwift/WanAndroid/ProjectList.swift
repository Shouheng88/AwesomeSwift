//
//  WanAndroid.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/1.
//

import SwiftUI
import Rswift

struct ProjectList: View {
    
    @ObservedObject private var viewModel: ProjectViewModel = ProjectViewModel()

    private var loadingMoreView: some View {
        Text(NSLocalizedString("wna_android_pull_to_load", comment: ""))
            .onAppear(perform: {
                viewModel.request()
            })
    }
    
    private var projectListView: some View {
        ZStack {
            ScrollView {
                ScrollViewReader(content: { proxy in
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
                    }
                })
            }
            Button("Scroll To Top", action: {
//                self.proxy.scrollTo(viewModel.projects.first?.id)
            })
        }.onAppear(perform: {
            viewModel.request()
        }).navigationTitle(R.string.localizable.wan_android())
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

struct WanAndroid_Previews: PreviewProvider {
    static var previews: some View {
        ProjectList()
    }
}
