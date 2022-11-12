//
//  AlertDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct PopupDemoView: View {
    
    @State var showAlert: Bool = false
    @State var showSheet: Bool = false
    @State var showPop: Bool = false
    @State var pickerIndex: Int = 0
    @State var dateSelection: Date = Date()
    @State var showCustomPop: Bool = false
    
    private var sheet: ActionSheet {
        return ActionSheet(title: Text("Sheet"), message: Text("Message"), buttons: [
            .destructive(Text("destructive"), action: {
                print("you clicked destructive")
            }),
            .destructive(Text("destructive"), action: {
                print("you clicked destructive")
            }),
            .default(Text("default"), action: {
                print("You cliked default")
            }),
            .cancel(Text("cancel"), action: {
                print("You want to cancel me???")
            })
        ])
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    print("clicked alert")
                    self.showAlert = true
                }, label: {
                    Text("Show Alert").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                }).alert(isPresented: $showAlert, content: {
                    Alert(title: Text("title"),
                          message: Text("message"),
                          primaryButton: .destructive(Text("primary")),
                          secondaryButton: .cancel())
                }).background(Rectangle().fill(.blue)) // 显示对话框
                
                Button(action: {
                    self.showSheet = true
                }, label: {
                    Text("Show actionSheet").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                }).actionSheet(isPresented: $showSheet, content: {sheet})
                    .background(Rectangle().fill(.orange))
                
                Button(action: {
                    self.showPop = true
                }, label: {
                    Text("Show sheet").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                }).background(Rectangle().fill(.green))
                    .sheet(isPresented: $showPop, content: {
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
//                    .popover(isPresented: $showPop, content: {
//                        PopLayerVeiew()
//                    })
                
                Button("Show Custom Pop", action: {
                    withAnimation {
                        self.showCustomPop = true
                    }
                }).frame(width: UIScreen.main.bounds.width-30, height: 40)
                    .background(Rectangle().fill(.purple))
                
                Picker("ss", selection: $pickerIndex, content: {
                    ForEach(0..<10) { idx in
                        Text("Selection \(idx)").foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-30, height: 40)
                    }
                }).frame(width: UIScreen.main.bounds.width-30, height: 40)
                    .background(Rectangle().fill(.green))
                
                Picker("tips", selection: $pickerIndex, content: {
                    ForEach(0..<5) { idx in
                        Text("No.\(idx)")
                    }
                }).pickerStyle(SegmentedPickerStyle())
                
                VStack(spacing: 60) {
                    Picker("tips", selection: $pickerIndex, content: {
                        ForEach(0..<5) { idx in
                            Text("No.\(idx)")
                        }
                    }).pickerStyle(WheelPickerStyle()).frame(height: 100)
                    
                    HStack {
                        Text("Pick Date")
                        Spacer()
                        DatePicker(selection: $dateSelection, displayedComponents: .date, label: {
                            Text("Date")
                        })
                    }.frame(width: UIScreen.main.bounds.width-30, height: 40)
                    
                    DatePicker(
                        "DatePicker",
                        selection: $dateSelection,
                        displayedComponents: .date
                    ).datePickerStyle(WheelDatePickerStyle())
                        .frame(height:80)
                    
                    DatePicker(
                        "DatePicker",
                        selection: $dateSelection,
                        displayedComponents: .hourAndMinute
                    ).datePickerStyle(WheelDatePickerStyle())
                        .frame(height:100)
                }
            }
        }
        .blur(radius: showCustomPop ? 6 : 0)
        .overlay(showCustomPop ? CustomPopView(showPop: $showCustomPop) : nil)
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
        return VStack {
            Text("This is the PopLayerVeiew")
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Click me to dismiss!!")
            })
        }
    }
}

struct AlertDemoView_Previews: PreviewProvider {
    static var previews: some View {
        PopupDemoView()
    }
}
