//
//  AlertDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

/// 弹窗示例
struct PopupDemoView: View {
    
    @State var showAlert: Bool = false
    @State var showSheet: Bool = false
    @State var showPop: Bool = false
    @State var pickerIndex: Int = 0
    @State var dateSelection: Date = Date()
    @State var showCustomPop: Bool = false
    
    private var sheet: ActionSheet {
        return ActionSheet(title: Text("标题"), message: Text("内容"), buttons: [
            .destructive(Text("destructive 按钮"), action: {
                print("你点击了 destructive 按钮")
            }),
            .destructive(Text("destructive 按钮"), action: {
                print("你点击了 destructive 按钮")
            }),
            .default(Text("default 按钮"), action: {
                print("你点击了 default 按钮")
            }),
            .cancel(Text("取消"), action: {
                print("你点击了 取消 按钮")
            })
        ])
    }
    
    private var sampleAlertDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "1. 消息对话框", desc: "基于 alert 实现")
            Button(action: {
                self.showAlert = true
            }, label: {
                Text("消息对话框")
            }).alert(isPresented: $showAlert, content: {
                Alert(title: Text("标题"),
                      message: Text("内容"),
                      primaryButton: .destructive(Text("确定")),
                      secondaryButton: .cancel())
            }) // 显示对话框
        }
    }
    
    private var sampleActionSheetDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "2. 底部对话框", desc: "基于 actionSheet 实现")
            Button(action: {
                self.showSheet = true
            }, label: {
                Text("底部对话框")
            }).actionSheet(isPresented: $showSheet, content: {sheet})
        }
    }
    
    private var sampleSheetDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "3. sheet 浮层", desc: "基于 sheet 方法实现")
            Button(action: {
                self.showPop = true
            }, label: {
                Text("显示 sheet 浮层")
            }).sheet(isPresented: $showPop, content: {
                if #available(iOS 16.0, *) {
                    NavigationStack {
                        PopLayerVeiew()
                    }
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                } else {
                    PopLayerVeiew()
                }
            })
        }
    }
    
    private var sampleCustomPopDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "4. 自定义浮层对话框", desc: "基于 overlay + blur 方法实现")
            Button("显示自定义浮层对话框", action: {
                withAnimation {
                    self.showCustomPop = true
                }
            })
        }
    }
    
    private var samplePickerDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "5. 弹出选择框", desc: "基于 Picker 实现，附其他样式的 Picker")
            Picker("ss", selection: $pickerIndex, content: {
                ForEach(0..<10) { idx in
                    Text("选项 \(idx)")
                }
            }).frame(width: UIScreen.main.bounds.width-30, height: 40)
            Picker("tips", selection: $pickerIndex, content: {
                ForEach(0..<5) { idx in
                    Text("选项 \(idx)")
                }
            }).pickerStyle(SegmentedPickerStyle())
            Picker("tips", selection: $pickerIndex, content: {
                ForEach(0..<5) { idx in
                    Text("选项 \(idx)")
                }
            }).pickerStyle(WheelPickerStyle()).frame(height: 100)
        }
    }
    
    private var sampleDatePickerDemoView: some View {
        VStack {
            SampleSectionTitleView(title: "6. 时间和日期选择框", desc: "基于 DatePicker 实现，附其他样式的 DatePicker")
            HStack {
                Text("日期选择")
                Spacer()
                DatePicker(selection: $dateSelection, displayedComponents: .date, label: {
                    Text("Label")
                })
            }.frame(width: UIScreen.main.bounds.width-30, height: 40)
            HStack {
                Text("时间选择")
                Spacer()
                DatePicker(selection: $dateSelection, displayedComponents: .hourAndMinute, label: {
                    Text("Label")
                })
            }.frame(width: UIScreen.main.bounds.width-30, height: 40)
            DatePicker(
                "日期选择",
                selection: $dateSelection,
                displayedComponents: .date
            ).datePickerStyle(WheelDatePickerStyle())
                .padding(.vertical, 20)
            DatePicker(
                "时间选择",
                selection: $dateSelection,
                displayedComponents: .hourAndMinute
            ).datePickerStyle(WheelDatePickerStyle())
                .padding(.vertical, 20)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                sampleAlertDemoView
                sampleActionSheetDemoView
                sampleSheetDemoView
                sampleCustomPopDemoView
                samplePickerDemoView
                sampleDatePickerDemoView
            }.padding(15)
        }
        .blur(radius: showCustomPop ? 6 : 0)
        .overlay(showCustomPop ? CustomPopView(showPop: $showCustomPop) : nil)
        .navigationTitle("弹窗示例")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CustomPopView: View {
    
    @State private var showAlert: Bool = false
    @Binding var showPop: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button("Show Alert", action: {
                    self.showAlert = true
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("alert from popup"),
                          message: Text("message"),
                          primaryButton: .destructive(Text("primary")),
                          secondaryButton: .cancel())
                })
                Spacer()
            }.padding(40).background(Rectangle().fill(.white))
                .cornerRadius(16)
                .transition(.offset(x: 0, y: 100))
        }
        .padding(.all, 8)
        // 灰色的背景
        .background(Color.black.opacity(0.3))
        // 点击背景消失
        .onTapGesture {
            self.showPop = false
        }
        .edgesIgnoringSafeArea(.all)
        .opacity(showAlert ? 0 : 1)
    }
}

struct PopLayerVeiew: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        return VStack(spacing: 15) {
            Text("自定义弹窗内容")
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("点击退出")
            })
        }
    }
}

struct AlertDemoView_Previews: PreviewProvider {
    static var previews: some View {
        PopupDemoView()
    }
}
