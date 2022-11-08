//
//  SegmentedViewDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI
import JXSegmentedView
import UIKit

struct SegmentedViewDemo: View {
    
    @ObservedObject private var vm: SegmentedViewModel = SegmentedViewModel()
    @State private var selection: Int = 0
    private let colors: [Color] = [.red, .green, .blue]

    var body: some View {
        VStack{
            SegmentedView(
                titles: self.$vm.titles,
                selectedIndex: self.$selection
            ).frame(width: UIScreen.main.bounds.size.width, height: 40)
            TabView(selection: $selection) {
                ForEach(0..<3) { idx in
                    VStack {
                        Text("Slide Page [\(idx)]").foregroundColor(.white)
                        Button("Click to Navigate to Next Page", action: {
                            let next = self.selection + 1
                            if next >= colors.count {
                                self.selection = 0
                            } else {
                                self.selection = next
                            }
                        }).frame(height: 40).foregroundColor(.white)
                    }.frame(width: UIScreen.main.bounds.width, height: 200)
                        .background(colors[idx])
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
        
        segmentedDataSource.titles = ["猴哥", "青蛙王子", "旺财"]
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
