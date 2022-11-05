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
    
    private var sheet: ActionSheet {
        return ActionSheet(title: Text("Shit"), message: Text("Message"), buttons: [
            .destructive(Text("Fuckkkkkkkkk!"), action: {
                print("you clicked fuck!")
            }),
            .destructive(Text("Shit"), action: {
                print("you clicked shit!")
            }),
            .default(Text("Damn it!"), action: {
                print("You cliked damn it!!")
            }),
            .cancel(Text("Cannnnnnncel"), action: {
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
                }).background(.blue) // 显示对话框
                
                Button(action: {
                    self.showSheet = true
                }, label: {
                    Text("Show Sheet").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                }).actionSheet(isPresented: $showSheet, content: {sheet})
                    .background(.orange)
                
                Button(action: {
                    self.showPop = true
                }, label: {
                    Text("Show Pop").foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-30, height: 40)
                }).background(.green)
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
                
                Picker("ss", selection: $pickerIndex, content: {
                    ForEach(0..<10) { idx in
                        Text("Selection \(idx)").foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-30, height: 40)
                    }
                }).frame(width: UIScreen.main.bounds.width-30, height: 40)
                    .background(.brown)
                
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
    }
}

struct PopLayerVeiew: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        return VStack {
            Text("This is the fucking pop!!!")
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
