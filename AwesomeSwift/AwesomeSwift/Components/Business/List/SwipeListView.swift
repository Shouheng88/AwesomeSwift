//
//  SwipeListView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import SwiftUI

struct SwipeListView: View {
    
    @State var messages: [Message] = (0...60).map { Message(text: "message:\($0)") }
    @State var swipedChannelId: String?
    
    var body: some View {
        List {
            ForEach(messages) { message in
                SwipeContainer(
                    child: MessageView(text: message.text),
                   swipedChannelId: $swipedChannelId
                ).onTapGesture {
                    debugPrint("on list item clicked")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }.navigationTitle("Swipe List Sample")
//            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)) // 无效
    }
}

struct MessageView: View {
    let text: String
    var body: some View {
        HStack {
            Spacer()
            Text(text).frame(height: 50)
            Spacer()
        }
    }
}

struct SwipeContainer: View {
    
    var child: MessageView
   
    @GestureState private var offset: CGSize = .zero
    @State private var offsetX: CGFloat = 0
    @State private var openSideLock: SwipeDirection?
    @Binding var swipedChannelId: String?

    private let openTriggerValue: CGFloat = 60

    private let itemWidth: CGFloat = 60
    private var menuWidth: CGFloat {
        itemWidth * CGFloat(2) + 8
    }

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                actions
            }
            child
                .background(Rectangle().fill(.gray))
                .offset(x: self.offsetX)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 10, coordinateSpace: .local)
                        .updating($offset) { ( value, gestureState, _) in
                            let diff = CGSize(
                                width: value.location.x - value.startLocation.x,
                                height: value.location.y - value.startLocation.y
                            )
                        
                            if diff == .zero {
                                gestureState = .zero
                            } else {
                                gestureState = value.translation
                            }
                        }
                )
                .onChange(of: offset, perform: { _ in
                    if offset == .zero {
                        // 手势结束之后的处理逻辑，这里是否无法判断暂停拖动的事件...
                        dragEnded()
                    } else {
                        // 拖动中的处理逻辑
                        dragChanged(to: offset.width)
                    }
                })
        }
    }
    
    private var actions: some View {
        HStack {
            Button("Action 0", action: {
                debugPrint("clicked action 0")
            }).frame(width: buttonWidth, height: 40)
            Button("Action 1", action: {
                debugPrint("clicked action 1")
            }).frame(width: buttonWidth, height: 40)
        }
//        .opacity(self.offsetX < -5 ? 1 : 0)
    }
    
    private let addWidthMargin: CGFloat = 5

    private var buttonWidth: CGFloat {
        let totalWidth = width(for: openSideLock ?? .trailing)
        let width = (offsetX.magnitude + addWidthMargin) * (itemWidth / totalWidth)
        return width
    }
    
    private func setOffsetX(value: CGFloat) {
        withAnimation {
            self.offsetX = value
        }
        if offsetX == 0 {
            openSideLock = nil
            swipedChannelId = nil
        }
    }
    
    // 判断是否达到指定的阈值，来决定菜单展开还是折叠
    private func dragEnded() {
        if offsetX == 0 {
            swipedChannelId = nil
            openSideLock = nil
        } else if offsetX < 0 {
            if offsetX.magnitude < openTriggerValue ||
                offsetX > -menuWidth * 0.8 {
                setOffsetX(value: 0)
            } else {
                lockSideMenu(side: .trailing)
            }
        } else {
            setOffsetX(value: 0)
        }
    }
    
    private func dragChanged(to value: CGFloat) {
        debugPrint("drag changed to \(value) openSideLock \(String(describing: openSideLock))")
        let horizontalTranslation = value
         
//        if horizontalTranslation < 0 && openSideLock == nil {
            // prevent swiping to right, if not configured.
//            return
//        }

        if let openSideLock = self.openSideLock {
            offsetX = width(for: openSideLock) * openSideLock.sideFactor + horizontalTranslation
            return
        }
                 
        if horizontalTranslation != 0 {
//            if swipedChannelId != channel.id {
//                swipedChannelId = channel.id
//            }
            offsetX = horizontalTranslation
        } else {
            offsetX = 0
        }
        debugPrint("on drag change \(offsetX)")
    }
    
    private func lockSideMenu(side: SwipeDirection) {
        setOffsetX(value: side.sideFactor * width(for: side))
        openSideLock = side
    }
    
    private func width(for direction: SwipeDirection) -> CGFloat {
        direction == .leading ? itemWidth : menuWidth
    }
}

public enum SwipeDirection {
    case leading
    case trailing
    
    var sideFactor: CGFloat {
        switch self {
        case .leading:
            return 1
        case .trailing:
            return -1
        }
    }
}

struct SwipeListView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeListView()
    }
}
