//
//  SectionListView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/12.
//

import SwiftUI

struct SectionListView: View {

    @State var groupedMessages: [GroupedMessage] = [
        GroupedMessage(title: "Messages 0~9",   messages: (0...9).map { Message(text: "message:\($0)") }),
        GroupedMessage(title: "Messages 10~19", messages: (10...19).map { Message(text: "message:\($0)") }),
        GroupedMessage(title: "Messages 20~29", messages: (20...29).map { Message(text: "message:\($0)") }),
        GroupedMessage(title: "Messages 30~39", messages: (30...39).map { Message(text: "message:\($0)") }),
    ]
    
    var body: some View {
        ScrollViewReader(content: { scrollView in
            ScrollView(content: {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
    //                List {
                        ForEach($groupedMessages) { groupedMessage in
                            Section(
                                header: Text(groupedMessage.wrappedValue.title)
                                    .frame(width: UIScreen.main.bounds.width, height: 30)
                                    .background(Rectangle()
                                        .fill(.gray))
                                ,
                                content: {
                                    ForEach(groupedMessage.wrappedValue.messages) { message in
                                        GroupeMessageView(title: "\(message.text)")
                                    }.onDelete(perform: nil)
                                }
                            )
                        }
    //                }
                }
            }).overlay(
                SectionIndexTitles(
                    scrollView: scrollView,
                    titles: groupedMessages.map({ groupedMessage in groupedMessage.title })
                )
                  .frame(maxWidth: .infinity, alignment: .trailing)
                  .padding(.trailing, 2)
            )
        }).navigationTitle("Section List Sample")
    }
}

struct GroupeMessageView: View {
    let title: String
    var body: some View {
        Text(title).frame(height: 40)
    }
}

struct GroupedMessage: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let messages: [Message]
}

  struct SectionIndexTitles: View {

    let scrollView: ScrollViewProxy
    let titles: [String]

    @GestureState
    private var dragLocation: CGPoint = .zero

    @State
    private var selectedTitle: String?

    @State
    private var showSelectionBubble = false

    var body: some View {
      VStack {
        ForEach(titles, id: \.self) { title in
          let isSelected = isSelectedIndex(withTitle: title)
          HStack {
            Spacer()

            SectionIndexSelectionBubble {
              Text(title)
                .foregroundColor(.white)
                .font(.system(size: ContactsListIndexConstant.bubbleTitleFontSize, weight: .bold))
            }
            .frame(
              width: ContactsListIndexConstant.bubbleSize.width,
              height: ContactsListIndexConstant.bubbleSize.height
            )
            .opacity(selectionBubbleOpacityForIndex(withTitle: title))
            .animation(showSelectionBubble ? .none : .easeOut, value: showSelectionBubble)

            SectionIndexTitle(
              title: title,
              isSelected: isSelected,
              onTap: {
                scrollToTitle(title)

                showSelectionBubble = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                  showSelectionBubble = false
                }
              }
            )
              .background(dragObserver(title: title))
          }
          .frame(height: ContactsListIndexConstant.indexTitleSize.height)
        }
      }
      .gesture(
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
          .updating($dragLocation) { value, state, _ in
            state = value.location
          }
          .onEnded({ _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
              showSelectionBubble = false
            }
          })
      )
    }

    private func isSelectedIndex(withTitle title: String) -> Bool? {
      selectedTitle == nil ? nil : selectedTitle! == title
    }

    private func selectionBubbleOpacityForIndex(withTitle title: String) -> Double {
      let isSelected = isSelectedIndex(withTitle: title)
      return isSelected == nil ? 0 : (isSelected! && showSelectionBubble) ? 1 : 0
    }

    private func dragObserver(title: String) -> some View {
      GeometryReader { geometry in
        dragObserver(geometry: geometry, title: title)
      }
    }

    private func dragObserver(geometry: GeometryProxy, title: String) -> some View {
      if geometry.frame(in: .global).contains(dragLocation) {
        DispatchQueue.main.async {
          scrollToTitle(title)
          showSelectionBubble = true
        }
      }
      return Rectangle().fill(Color.clear)
    }

    private func scrollToTitle(_ title: String) {
      guard selectedTitle != title else {
        return
      }
      scrollView.scrollTo(title, anchor: .top)
      selectedTitle = title
    }
  }

struct SectionIndexTitle: View {

    let title: String
    let isSelected: Bool?
    let onTap: () -> Void

    var body: some View {
      Text(title)
        .font(.system(size: ContactsListIndexConstant.indexTitleFontSize, weight: .semibold))
        .frame(
          width: ContactsListIndexConstant.indexTitleSize.width,
          height: ContactsListIndexConstant.indexTitleSize.height
        )
        .cornerRadius(cornerRadius)
        .contentShape(Rectangle()) // 解决问题：背景色为透明时，手势无效
        .onTapGesture(perform: onTap)
    }

    private var cornerRadius: CGFloat {
      isSelected == nil ?
      0 :
      isSelected! ? ContactsListIndexConstant.indexTitleBackgroundCornerRaidus : 0
    }
  }

  struct SectionIndexSelectionBubble<Title: View>: View {
    let title: () -> Title

    var body: some View {
      GeometryReader { geo in

        let startDegree: CGFloat = 45
        let startRadius: CGFloat = startDegree * .pi / 180
        let height = geo.size.height
        let radius = height * 0.5

        let deltaX = cos(startRadius) * radius
        let deltaY = sin(startRadius) * radius

        HStack(spacing: -(radius - deltaX)) {
          ZStack {
            Path { path in
              path.addArc(
                center: .init(x: radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: 360 - Double(startDegree)),
                endAngle: Angle(degrees: Double(startDegree)),
                clockwise: true
              )
            }

            title()
          }
          .frame(width: geo.size.height, height: geo.size.height)

          Path { path in
            let topPoint = CGPoint(x: 0, y: radius - deltaY)
            let bottomPoint = CGPoint(x: 0, y: radius + deltaY)

            let deltaX2 = tan(startRadius) * deltaY
            let leftPoint = CGPoint(x: deltaX2, y: radius)

            path.move(to: topPoint)
            path.addLine(to: leftPoint)
            path.addLine(to: bottomPoint)
          }
          .frame(height: geo.size.height)

          Spacer()
        }
      }
    }
  }

private enum ContactsListIndexConstant {
  static let bubbleTitleFontSize: CGFloat = 25
  static let bubbleSize: CGSize = .init(width: 70, height: 50)
  static let indexTitleSize: CGSize = .init(width: 16, height: 16)
  static let indexTitleFontSize: CGFloat = 11
  static let indexTitleBackgroundCornerRaidus: CGFloat = 8
}


struct SectionListView_Previews: PreviewProvider {
    static var previews: some View {
        SectionListView()
    }
}
