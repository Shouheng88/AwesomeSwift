//
//  KeyboardAwareDemoView2.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/6.
//

import SwiftUI

@available(iOS 15.0, *)
struct KeyboardAwareDemoView2: View {

    @State private var text = ""
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }

    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                List {
                    ForEach(messages) { message in
                        TextField(text: self.$text, label: {
                            Text(message.text).id(message.id)
                        })
                    }
                }
                .listStyle(.inset)
                .safeAreaInset(edge: .bottom) {
                    SendEdge(messages: $messages)
                }
            }
        }.navigationBarTitleDisplayMode(.inline)
    }
    
    private struct SendEdge: View {

        @Binding var messages: [Message]
        @FocusState var focused: Bool
        @State private var text = ""

        var body: some View {
            ZStack(alignment: .top) {
                Color.clear
                Rectangle()
                    .fill(.secondary)
                    .opacity(0.3).frame(height: 0.6) // 上部线条
                HStack(alignment: .firstTextBaseline) {
                    // 输入框
                    TextField("", text: $text)
//                    TextField(text: $text)
                        .focused($focused)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                        .onSubmit {
                            debugPrint("commited")
                            messages.append(Message(text: text))
                        }
                        .onChange(of: focused) { value in
                            
                        }
                    // 回复按钮
                    Button("回复") {
                        focused = false
                        messages.append(Message(text: text))
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.small)
                    .tint(.green)
                }
                .padding(.horizontal, 30)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 53)
            .background(.regularMaterial)
        }
    }
}

struct Message: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

struct KeyboardAwareDemoView2_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15.0, *) {
            KeyboardAwareDemoView2()
        } else {
            Text("Only available on 15.0 and newer")
        }
    }
}
