//
//  StackDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct LayoutDemoView: View {

    private var hStackSampleView: some View {
        ScrollView(.horizontal) {
            HStack {
                Text("HStack allows you to layout child views in horizontal layout.")
                    .padding(.bottom, 30)
                    .border(.green, width: 1)
                Text("Performs like Andrioid LinearLayout with horiziontal mode.")
                    .padding(.top, 30)
                    .padding(.horizontal, 10)
                    .border(.green, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
        }
    }
    
    private var contentAlignmentSampleView: some View {
        VStack {
            ZStack {
                Divider()
                HStack {
                    // The alignment in frame of Text is used to set how the content layout.
                    Text("1")
                        .frame(width: 50, height: 50, alignment: .topLeading)
                        .border(.green, width: 1)
                    Text("2")
                        .frame(width: 50, height: 50, alignment: .bottomTrailing)
                        .border(.green, width: 1)
                }.padding(.horizontal, 30)
                    .padding(.top, 10)
                    // Alignment in frame is used to specify how to layout content in HStack.
                    .frame(height: 90, alignment: .top).border(.blue, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
            
            ZStack {
                Divider()
                // Alignment in HStack constructor is used to specify how content align in HStack.
                HStack(alignment: .top) {
                    Text("3")
                        .frame(width: 50, height: 50, alignment: .bottomLeading)
                        .border(.green, width: 1)
                    Text("4")
                        .frame(width: 60, height: 60, alignment: .topTrailing)
                        .border(.green, width: 1)
                }.padding(.horizontal, 30).frame(height: 90).border(.blue, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
            
            ZStack {
                Divider()
                HStack(alignment: .firstTextBaseline) {
                    Text("1")
                        .frame(width: 50, height: 50, alignment: .topLeading)
                        .border(.green, width: 1)
                    Text("2")
                        .frame(width: 50, height: 50, alignment: .bottomTrailing)
                        .border(.green, width: 1)
                    Text("3")
                        .frame(width: 50, height: 50)
                        .border(.green, width: 1)
                }.padding(.horizontal, 30).frame(height: 90).border(.blue, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
            
            ZStack {
                Divider()
                HStack(alignment: .lastTextBaseline) {
                    Text("1")
                        .frame(width: 50, height: 50, alignment: .topLeading)
                        .border(.green, width: 1)
                    Text("2")
                        .frame(width: 50, height: 50, alignment: .bottomTrailing)
                        .border(.green, width: 1)
                    Text("3")
                        .frame(width: 50, height: 50)
                        .border(.green, width: 1)
                }.padding(.horizontal, 30).frame(height: 90).border(.blue, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
            
            VStack(spacing: 10) {
                Text("The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value.")
                    .multilineTextAlignment(.leading)
                Text("The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value.")
                    .multilineTextAlignment(.center)
                Text("The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value.")
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    
    private var alignementGuideSampleView: some View {
        VStack {
            ZStack {
                Divider()
                HStack(alignment: .center) {
                    Text("1")
                        .frame(width: 50, height: 50)
                        .border(.green, width: 1)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in 10 })
                    Text("2")
                        .frame(width: 50, height: 50)
                        .border(.green, width: 1)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in -10 })
                    Text("3")
                        .frame(width: 50, height: 50)
                        .border(.green, width: 1)
                        .alignmentGuide(VerticalAlignment.center, computeValue: { d in 0 })
                }.padding(.horizontal, 30).frame(height: 90).border(.blue, width: 1)
            }.frame(height: 100).border(.gray, width: 1)
            
//            Text(self.tip).foregroundColor(.gray).font(.system(size: 14))
            ZStack {
                Divider()
                HStack {
                    Divider()
                }
                Group {
                    VStack(alignment: .leading) {
                        Text("1")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in 10 })
                        Text("2")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in -10 })
                        Text("3")
                            .frame(width: 50, height: 50)
                            .border(.green, width: 1)
                            .alignmentGuide(HorizontalAlignment.leading, computeValue: { d in
                                let info = "Squre[3]: width[\(d.width)], height[\(d.height)], h.center[\(d[HorizontalAlignment.center])], h.leading[\(d[HorizontalAlignment.leading])], h.trailing[\(d[HorizontalAlignment.trailing])], v.top[\(d[VerticalAlignment.top])], v.bottom[\(d[VerticalAlignment.bottom])], v.center[\(d[VerticalAlignment.center])]"
                                debugPrint(info)
                                return 0
                            })
                    }.padding(10).border(.blue, width: 1)
                }.padding(.vertical, 5)
            }.border(.gray, width: 1)
        }
    }
    
    var body: some View {
        ScrollView(content: {
            VStack {
                hStackSampleView
                contentAlignmentSampleView
                alignementGuideSampleView
            }.padding(.horizontal, 10)
        }).navigationBarTitle("Layout Demo", displayMode: .inline)
    }
}

struct StackDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemoView()
    }
}
