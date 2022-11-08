//
//  KeyboardAwareDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/6.
//

import SwiftUI


struct KeyboardAwareDemoView: View {
    
    @State private var text = ""
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                List {
                    ForEach(messages) { message in
                        TextField(message.text, text: self.$text)
                    }
                }
                if #available(iOS 15.0, *) {
                    SendAbove15(proxy: proxy)
                } else {
                    Send(proxy: proxy)
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    @available(iOS 15.0, *)
    private struct SendAbove15: View {
        @State private var text: String = ""
        @FocusState var keyboardFcused: Bool
        @State private var showCalendar: Bool = false
        @State private var keyboardHeight: CGFloat = 0.0

        let proxy: GeometryProxy
    
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ZStack {
                    // The Color will extand the layout of ZStack too large.
//                    Color(R.color.custom_color()!)
                    VStack {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar.circle").onTapGesture {
                                // Get keyboard height.
                                keyboardHeight = proxy.safeAreaInsets.bottom
                                showCalendar = true
                            }
                            TextEditor(text: $text)
                                .cornerRadius(4)
                                .focused($keyboardFcused)
                                .border(.gray)
                            Image(systemName: "tray.circle")
                            Image(systemName: "paperplane").onTapGesture {
                                keyboardFcused = false
                            }
                        }
                        .padding(.horizontal, 12)
                        .frame(height: keyboardFcused ? 100 : 56)
                        Text("Calendar Container")
                            .frame(height: showCalendar && !keyboardFcused ? keyboardHeight : 0)
                    }
                }
            }
        }
    }
    
    private struct Send: View, EventReceiver {

        @State private var text: String = ""
        @State private var showCalendar: Bool = false
        @State private var keyboardFcused: Bool = false
        private let keboardEventReceiver = KeboardEventReceiver()

        let proxy: GeometryProxy
                
        var body: some View {
            VStack(spacing: 0) {
                Divider()
                ZStack {
                    VStack {
                        HStack(spacing: 12) {
                            Image(systemName: "calendar.circle").onTapGesture {
                                
                            }
                            TextEditor(text: $text)
                                .cornerRadius(4)
                                .border(.gray)
                            Image(systemName: "tray.circle")
                            Image(systemName: "paperplane").onTapGesture {
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
                        .padding(.horizontal, 12)
                        .frame(height: keyboardFcused ? 100 : 56)
                    }
                }
            }.onAppear(perform: {
                keboardEventReceiver.registerReceiver(receiver: self)
                keboardEventReceiver.registerForKeyboardNotifications()
            }).onDisappear(perform: {
                keboardEventReceiver.unRegisterForKeyboardNotifications()
            })
        }
        
        func onReceive(hide: Bool) {
            self.keyboardFcused = !hide
        }
    }
}

/// Keyboard show and hide event detector.
class KeboardEventReceiver {
    
    private var receivers: [EventReceiver] = []

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShown(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func unRegisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    func registerReceiver(receiver: EventReceiver) {
        receivers.append(receiver)
    }
    
    @objc func keyboardWillShown(_ notificiation: NSNotification) {
        debugPrint("keyboard shown")
        receivers.forEach({ receiver in
            receiver.onReceive(hide: false)
        })
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        debugPrint("keyboard hidden")
        receivers.forEach({ receiver in
            receiver.onReceive(hide: true)
        })
    }
}

protocol EventReceiver {
    func onReceive(hide: Bool)
}

struct KeyboardAwareDemoView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardAwareDemoView()
    }
}
