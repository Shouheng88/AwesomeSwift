//
//  WhatsNewKitView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/5.
//

import SwiftUI
import WhatsNewKit

struct WhatsNewKitView: View {
    
    @State private var whatsNew: WhatsNew?
    @State private var showCustomWhatsNew: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Show Whats New", action: {
                // 给 self.whatsNew 赋值的时候即展示
                self.whatsNew = buildWhatsNew()
            }).frame(height: 40)

            Button("Show Whats New", action: {
                self.showCustomWhatsNew = true
            }).frame(height: 40)

            Spacer()
        }.sheet(isPresented: $showCustomWhatsNew, content: {
            WhatsNewView(whatsNew: buildWhatsNew())
        })
//        .whatsNewSheet()
        .sheet(whatsNew: self.$whatsNew)
    }
    
    private func buildWhatsNew() -> WhatsNew {
        WhatsNew(
            version: .init(stringLiteral: "1.1.1"),
            title: "Whats New Title",
            features: [
                .init(image: WhatsNew.Feature.Image(image: {
                    Image(uiImage: R.image.heart_lock()!)
                }), title: "item title 1", subtitle: "item sub title 1"),
                .init(image: WhatsNew.Feature.Image(image: {
                    Image(uiImage: R.image.heart_diamond()!)
                }), title: "This is a title for super long text test.",
                      subtitle: "This is a sub title for super long text test for WhatsNewKit demonstrate. What do you think of this kind of ui of swift ?"),
            ],
            primaryAction: .init(
                backgroundColor: .cyan
            ),
            secondaryAction: .init(
                title: "About Translation & Privacy",
                foregroundColor: .cyan,
                action: .openURL(
                    .init(string: "https://apple.com/privacy")
                )
            )
        )
    }
}

struct WhatsNewKitView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewKitView()
    }
}
