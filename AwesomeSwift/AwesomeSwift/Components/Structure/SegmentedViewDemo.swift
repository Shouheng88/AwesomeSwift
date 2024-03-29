//
//  SegmentedViewDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI
import JXSegmentedView
import UIKit

/// 顶部导航栏示例
struct SegmentedViewDemo: View {
    
    @ObservedObject private var vm: SegmentedViewModel = SegmentedViewModel()
    @State private var selection: Int = 0
    private let colors: [Color] = [.red.opacity(0.1), .green.opacity(0.1), .blue.opacity(0.1)]
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            HStack {
                Image(systemName: "arrow.left")
                    .padding(10)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        presentationMode.wrappedValue.dismiss()
                    }
                Text("顶部导航栏示例")
                Spacer()
            }.padding(.leading, 5)
            SegmentedView(
                titles: self.$vm.titles,
                selectedIndex: self.$selection
            ).frame(width: UIScreen.main.bounds.size.width, height: 40)
            TabView(selection: $selection) {
                ForEach(0..<3) { idx in
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("页面 [\(idx)]")
                            Spacer()
                        }
                        Button("点击跳转到下一个页面", action: {
                            let next = self.selection + 1
                            if next >= colors.count {
                                self.selection = 0
                            } else {
                                self.selection = next
                            }
                        })
                        Spacer()
                    }.background(colors[idx])
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }.onAppear(perform: {
            vm.requestTabs()
        }).navigationBarHidden(true)
    }
}

struct SegmentedView: UIViewRepresentable {

    @Binding var titles: [String]
    @Binding var selectedIndex: Int

    private let segmentedDataSource = JXSegmentedTitleDataSource()
    private let segmentedView = JXSegmentedView()
    
    class Coordinator: NSObject, JXSegmentedViewDelegate {
        var parent: SegmentedView

        init(_ parent: SegmentedView) {
          self.parent = parent
        }

        // 用来指定指定的 index 是否可以点击
        func segmentedView(_ segmentedView: JXSegmentedView, canClickItemAt index: Int) -> Bool {
            print("canClickItemAt index [\(index)]")
            return true
        }
        
        // 当点击发生了之后回调，刷新状态数据
        func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
            print("didSelectedItemAt index [\(index)]")
            self.parent.selectedIndex = index
        }
        
        func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
            print("didClickSelectedItemAt index [\(index)]")
        }
        
        func segmentedView(_ segmentedView: JXSegmentedView, didScrollSelectedItemAt index: Int) {
            print("didScrollSelectedItemAt index [\(index)]")
        }
        
        func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
            print("scrollingFrom leftIndex [\(leftIndex)], rightIndex[\(rightIndex)], percent[\(percent)]")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        print("SegmentedView makeCoordinator called")
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> JXSegmentedView {
        print("SegmentedView makeUIView called")

        segmentedView.delegate = context.coordinator
        segmentedView.defaultSelectedIndex = selectedIndex
        
        segmentedDataSource.titles = ["页面 1", "页面 2", "页面 3"]
        segmentedDataSource.isTitleColorGradientEnabled = true
        segmentedView.dataSource = self.segmentedDataSource
        
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 20
        segmentedView.indicators = [indicator]
        
        return segmentedView
    }
    
    func updateUIView(_ uiView: JXSegmentedView, context: Context) {
        print("SegmentedView updateUIView called, selected[\(selectedIndex)] title[\(titles)]")
        if uiView.selectedIndex != selectedIndex {
            uiView.selectItemAt(index: selectedIndex)
        }
    }
}

class SegmentedViewModel: ObservableObject {

    @Published var titles: [String] = []

    func requestTabs() {
        titles = ["TAB A", "TAB B", "TAB C"]
    }
}

struct SegmentedViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedViewDemo()
    }
}
