//
//  AnimationDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/18.
//

import SwiftUI

struct AnimationDemoView: View {
    
    @State private var dragAmount: CGSize = .zero
    
    @State private var letterBkgColor: Color = .green
    
    @State private var showSquare: Bool = false
    
    var body: some View {
        VStack {
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
                )
            
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
            
            VStack {
                Button(action: {
                    // 动画是添加到这里的 ...
                    withAnimation(.easeInOut(duration: 0.4)) {
                        self.showSquare.toggle()
                    }
                }, label: {
                    Text("Tap Me!")
                })
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
