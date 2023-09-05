//
//  GestureDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2023/9/5.
//

import SwiftUI

/// 手势示例
struct GestureDemoView: View {
    
    @State private var tip: String = ""
    @State private var dragAmount: CGSize = .zero
    @State private var letterBkgColor: Color = .green

    private var dragMoveSampleView: some View {
        VStack {
            SampleSectionTitleView(title: "3. 拖拽效果")
            LinearGradient(
                colors: [.red, .green, .blue],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged({ state in
                            self.dragAmount = state.translation
                        })
                        .onEnded({ _ in
                            withAnimation(.spring(), {
                                self.dragAmount = .zero
                            })
                        })
                ).overlay(Text("拖动我"))
            HStack {
                ForEach(0..<6) { index in
                    Text("\(index)")
                        .padding(10)
                        .font(.headline)
                        .background(self.letterBkgColor)
                        .offset(self.dragAmount)
                        .animation(
                            Animation.easeOut(duration: 0.5).delay(0.1 * Double(index))
                        )
                }
            }.gesture(
                DragGesture()
                    .onChanged({ state in
                        self.dragAmount = state.translation
                    })
                    .onEnded({ _ in
                        self.dragAmount = .zero
                    })
            )
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(self.tip).foregroundColor(.gray).font(.system(size: 14))
                Group {
                    SampleSectionTitleView(title: "1. 长按事件")
                    Text("请长按我")
                        .simultaneousGesture(
                            LongPressGesture().onEnded({_ in
                                self.tip = "长按了控件"
                            })
                        )
                }
                Group {
                    SampleSectionTitleView(title: "2. 连点事件")
                    Text("请连点我")
                        .highPriorityGesture(
                            TapGesture(count: 3).onEnded({
                                self.tip = "连续点击了控件"
                            })
                        )
                }
                dragMoveSampleView
            }.padding(15)
        }.navigationTitle("手势示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct GestureDemoView_Previews: PreviewProvider {
    static var previews: some View {
        GestureDemoView()
    }
}
