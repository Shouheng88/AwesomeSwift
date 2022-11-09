//
//  ButtonDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/14.
//

import Rswift
import SwiftUI

struct ButtonDemoView: View {
    
    @State var isToggleOn: Bool = false
    @State var slideValue = 0.0
    @State var stepValue = 0
    @State var tip: String = "Button Demo"
    @State var bold: Bool = false
    @State var stepperValue = 0
    
    var buttonSampleView: some View {
        Section(content: {
            VStack(content: {
                Text(self.tip).foregroundColor(.gray).font(.system(size: 14))
                
                Button(action: {
                    self.tip = "You clicked a Button."
                }, label: {
                    Text("Normal Button")
                }).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(Rectangle().fill(.green))
                    .cornerRadius(8, antialiased: true)
                
                Button(action: {
                    self.tip = "You clicked Custom Text Button."
                }, label: {
                    Text("Custom Text Button")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                }).background(Rectangle().fill(.orange))
                    .cornerRadius(8, antialiased: true)
                
                Button(action: {
                    self.tip = "You clicked Animation Button."
                }, label: {
                    Text("Animation Button")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                }).background(Rectangle().fill(.blue))
                    .cornerRadius(8, antialiased: false)
                    .animation(.easeIn(duration: 5))
                
                Button(action: {
                    self.tip = "You clicked a Button with opacity."
                }, label: {
                    Text("Button with Opacity")
                }).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(Rectangle().fill(.purple))
                    .cornerRadius(8, antialiased: true)
                    .opacity(0.5)
                
                Button(action: {
                    self.tip = "You clicked a Button that send a notification."
                    NotificationCenter.default.post(name: NSNotification.Name(Events.SMAPLE_NOTIFICATION_NAME), object: Message(text: "Hello world!"))
                }, label: {
                    Text("Button to Send Notification").foregroundColor(.white)
                }).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(RoundedRectangle(cornerRadius: 10, style: .circular))
                    .foregroundColor(.green)
                
                Button(action: {
                    self.tip = "You clicked a Button with Icon."
                }, label: {
                    HStack(content: {
                       Image(systemName: "trash")
                            .font(.system(size: 14))
                       Text("Button with Icon")
                            .font(.system(size: 14))
                   })
                   .padding()
                   .foregroundColor(.white)
                   .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                   .cornerRadius(40)
                   .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 4))
                })
            })
        }, header: {
            Text("Button Samples")
        })
    }
    
    var toggleSampleView: some View {
        Section(content: {
            VStack {
                Toggle(isOn: $isToggleOn) {
                    
                }
                Group {
                    Toggle(isOn: $isToggleOn) {
                        // 这里其实是作为 toogle 按钮之前的一部内容
                        HStack {
                            Spacer()
                            Text("Switch: \(self.isToggleOn ? "On" : "Off")")
                        }
                    }
                    Text("Toggle Button with Text").foregroundColor(.gray).font(.system(size: 14))

                    Toggle(isOn: $bold) {
                        Image(systemName: "bold")
                    }
                    Text("Toggle Button with Image").foregroundColor(.gray).font(.system(size: 14))

                    if #available(iOS 15.0, *) {
                        Toggle(isOn: $bold) {
                            Image(systemName: "bold")
                        }.toggleStyle(.button)
                        Text(".button Toggle Button with Image").foregroundColor(.gray).font(.system(size: 14))
                    }

                    Toggle(isOn: $bold) {
                        Image(systemName: "bold")
                    }.toggleStyle(.automatic)
                    Text(".automatic Toggle Button with Image").foregroundColor(.gray).font(.system(size: 14))

                    Toggle(isOn: $bold) {
                        Image(uiImage: R.image.heart_lock()!)
                    }
                    Text("Toggle Button with Custom Image").foregroundColor(.gray).font(.system(size: 14))
                }
            }
        }, header: {
            Text("Toggle Sample View")
        })
    }
    
    var sliderSampleView: some View {
        Section(content: {
            Slider(value: $slideValue, in: 0...10, label: {
                Text("What ???")
            }, minimumValueLabel: {
                Text("Zero")
            }, maximumValueLabel: {
                Text("Hezo")
            })
            Slider(value: $slideValue, in: 0...100, label: {
                Text("What ???")
            }, minimumValueLabel: {
                Text("Zero")
            }, maximumValueLabel: {
                Text("Hezo")
            })
            Slider(value: $slideValue, in: 0...100, step: 1, label: {
                Text("What ???")
            }, minimumValueLabel: {
                Text("Zero")
            }, maximumValueLabel: {
                Text("Hezo")
            })
            Text("Slide vlaue: \(self.slideValue)")
                .foregroundColor(.gray)
                .font(.system(size: 14))
        }, header: {
            Text("Slider Sample View")
        })
    }
    
    var stepperSampleView: some View {
        Section(content: {
            VStack(content: {
                Stepper(value: $stepValue, step: 2, label: {
                    Text("Stepper value [\(self.stepValue)]")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                })
                
                Stepper(label: {
                    Text("Stepper value [\(self.stepperValue)]")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }, onIncrement: {
                    self.stepperValue = self.stepperValue + 5
                }, onDecrement: {
                    self.stepperValue = self.stepperValue - 5
                }, onEditingChanged: { editing in
                    print("editing \(editing)")
                })
            })
        }, header: {
            Text("Stepper Sample")
        })
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                buttonSampleView
                toggleSampleView
                sliderSampleView
                stepperSampleView
                
                NavigationLink(destination: {
                    Text("Hello from another Page :D")
                }, label: {
                    Text("Navigation Button").foregroundColor(.white)
                }).padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .background(Rectangle().fill(.blue))
                    .cornerRadius(8)
                
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
            }.padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
        }.navigationTitle("SwiftUI Button Demo")
    }
}

struct ButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonDemoView()
    }
}
