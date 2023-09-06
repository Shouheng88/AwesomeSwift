//
//  KeyboardAwareDemo3.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/9.
//

import SwiftUI

struct KeyboardAwareDemo3: View {
    
    @State private var text = ""
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }
    
    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(messages) { message in
                    TextField(message.text, text: self.$text)
                }
            }
            SendEdge()
        }.ignoresSafeArea(.keyboard).navigationBarTitleDisplayMode(.inline)
    }
    
    private struct SendEdge: View, KeyboardReadable {

        @State private var text = ""
        @State private var showEmoij = false
        @State private var keyboardHeightValue: CGFloat = 0
        @State private var keyboardShowing: Bool = false
        @State private var keyboardHiden: Bool = true

        var body: some View {
            VStack {
                Divider()
                HStack {
                    Button("Emoij", action: {
                        hideKeyboard()
                        self.showEmoij = !self.showEmoij
                    }).frame(height: 35)
                    TextEditor(text: $text)
                        .cornerRadius(4)
                        .border(.gray)
                        .frame(minHeight: 50, maxHeight: keyboardShowing ? 150 : 50)
                    Button("Send", action: {
                        hideKeyboard()
                    }).frame(height: 35)
                }
                if !keyboardHiden {
                    VStack {
                        Text("Emoij Container")
                    }.frame(height: keyboardHeightValue)
                }
            }.onReceive(keyboardHeight, perform: { height in
                keyboardHeightValue = height
            }).onReceive(keyboardDidChangePublisher, perform: { show in
                keyboardHiden = !show
            }).onReceive(keyboardWillChangePublisher, perform: { show in
                keyboardShowing = show
            })
        }
    }
}

struct KeyboardAwareDemo3_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardAwareDemo3()
    }
}
