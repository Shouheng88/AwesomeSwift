//
//  ButtonDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import SwiftUI

struct ButtonDemoView: View {
    
    @State var isToggleOn: Bool = false
    
    @State var slideValue = 0.0
    
    @State var stepValue = 0
    
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    print("你点击了普通按钮")
                }, label: {
                    Text("普通按钮")
                }).padding(5)
                    .border(.black, width: 2)
                    .cornerRadius(10, antialiased: true)
                
                Button(action: {
                    print("你点击了按钮")
                }, label: {
                    Text("按钮")
                }).background(.gray)
                    .padding(5)
                    .cornerRadius(10, antialiased: true)
                
                Button(action: {
                    print("你点击了按钮")
                }, label: {
                    Text("按钮").padding(8)
                }).background(.gray)
                    .cornerRadius(10, antialiased: false)
                
                Toggle(isOn: $isToggleOn) {
                    Text("开关 \(self.isToggleOn ? "On" : "Off")")
                }.padding(10)
                
                VStack {
                    Slider(value: $slideValue, in: 0...10, label: {
                        Text("What???")
                    }, minimumValueLabel: {
                        Text("MIN")
                    }, maximumValueLabel: {
                        Text("MAX")
                    })
                    Text("Slide vlaue: \(self.slideValue)")
                }
                
                Stepper(value: $stepValue, step: 2, label: {
                    Text("Stepper value [\(self.stepValue)]")
                })
                Stepper(label: {
                    Text("Stepper2")
                }, onIncrement: {
                    print("increased ")
                }, onDecrement: {
                    print("decreaced ")
                }, onEditingChanged: { editing in
                    print("editing \(editing)")
                })
            }
            
            NavigationLink(destination: {
                Text("Hello!!!")
            }, label: {
                Text("跳转按钮")
            })
            
            List {
                ForEach(0..<4) { i in
                    // 这样的方式只有点击 text 的时候有效
                    Text("Hello \(i)").onTapGesture {
                        print("点击了 No.\(i)")
                    }
                }.onDelete(perform: { idx in
                    print("on delete")
                }).onMove { IndexSet, Int in
                    print("on move")
                }
            }
        }
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemoView()
    }
}
