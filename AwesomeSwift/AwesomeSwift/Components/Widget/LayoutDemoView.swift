//
//  StackDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

/// 布局示例
struct LayoutDemoView: View {

    private var hStackSampleView: some View {
        VStack {
            SampleSectionTitleView(title: "1. HStack 示例")
            ScrollView(.horizontal) {
                HStack {
                    Text("HStack 允许在水平方向上布局")
                        .padding(.bottom, 30)
                        .border(.green, width: 1)
                    Text("效果类似 Android 的 LinearLayout")
                        .padding(.top, 30)
                        .padding(.horizontal, 10)
                        .border(.green, width: 1)
                }.frame(height: 100).border(.gray, width: 1)
            }
        }
    }
    
    private var contentAlignmentSampleView: some View {
        VStack {
            Group {
                SampleSectionTitleView(title: "2. frame 方法的 alignment 属性",
                                       desc: "该属性用在容器上，用来指定容器内元素的对齐方式")
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
            }
            Group {
                SampleSectionTitleView(title: "3. HStack 构造方法的 alignment 属性",
                                       desc: "该属性用在容器上，分别是 .firstTextBaseline 和 .lastTextBaseline")
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
                            .frame(width: 50, height: 50, alignment: .bottom)
                            .border(.green, width: 1)
                    }.padding(.horizontal, 30).frame(height: 90).border(.blue, width: 1)
                }.frame(height: 100).border(.gray, width: 1)
            }
            
            Group {
                SampleSectionTitleView(title: "4. 多行文本的对齐方式")
                VStack(spacing: 10) {
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Text(Consts.longText)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
    
    private var alignementGuideSampleView: some View {
        VStack {
            Group {
                SampleSectionTitleView(title: "5. 垂直对齐", desc: "alignmentGuide 方法垂直居中微调")
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
            }
            Group {
                SampleSectionTitleView(title: "6. 水平对齐", desc: "alignmentGuide 方法水平居中微调")
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
    }
    
    var body: some View {
        ScrollView {
            VStack {
                hStackSampleView
                contentAlignmentSampleView
                alignementGuideSampleView
            }.padding(15)
        }.navigationBarTitle("布局示例", displayMode: .inline)
    }
}

struct StackDemoView_Previews: PreviewProvider {
    static var previews: some View {
        LayoutDemoView()
    }
}
