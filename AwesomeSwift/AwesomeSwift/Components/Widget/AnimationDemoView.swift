//
//  AnimationDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/18.
//

import SwiftUI

/// 动画示例
struct AnimationDemoView: View {
    
    @State private var showSquare: Bool = false
    @State private var animationIndex = 0
    @State private var tip: String = ""
    
    private var toggleSampleView: some View {
        VStack {
            SampleSectionTitleView(title: "1. 入场动画")
            Button(action: {
                // 动画是添加到这里的 ...
                self.animationIndex = self.animationIndex + 1
                switch animationIndex % 3 {
                case 0:
                    self.showSquare.toggle()
                    self.tip = "无动画出现"
                case 1:
                    withAnimation {
                        self.showSquare.toggle()
                    }
                    self.tip = "使用动画出现"
                case 2:
                    withAnimation(.easeInOut(duration: 0.4)) {
                        self.showSquare.toggle()
                    }
                    self.tip = "使用动画和自定义时长出现"
                default:
                    break
                }
            }, label: {
                Text("点我")
            })
            Text(tip).font(.system(size: 14)).foregroundColor(.gray)
            if showSquare {
                Rectangle()
                    .fill(.pink)
                    .frame(width: 100, height: 100)
                    .transition(.asymmetric(insertion: .scale, removal: .scale))
                Rectangle()
                    .fill(.blue)
                    .frame(width: 100, height: 100)
                    .transition(
                        .modifier(
                            active: CornerRotationModifier(angle: .radians(-.pi/2), anchor: .topLeading),
                            identity: CornerRotationModifier(angle: .radians(0), anchor: .topLeading)
                        )
                    )
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                toggleSampleView
            }.padding(15)
        }.navigationTitle("动画示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct CornerRotationModifier: ViewModifier {
    let angle: Angle
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(angle, anchor: anchor)
            .clipped()
    }
}

struct AnimationDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationDemoView()
    }
}
