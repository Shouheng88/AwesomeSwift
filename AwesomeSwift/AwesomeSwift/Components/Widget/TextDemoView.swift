//
//  TextViewDemo.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI
import MarqueeLabel

/// 文本控件示例
struct TextDemoView: View {

    @State private var text = ""
    
    @State private var index: Int = 0
    
    private var sampleMarqueeLabelView: some View {
        VStack {
            SampleSectionTitleView(title: "1. 走马灯效果", desc: "三方控件 MarqueeLabelView")
            MarqueeLabelView(text: self.$text)
            //                    .frame(width: 300, height: 40)
                .onAppear(perform: {
                    self.text = "The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value."
                })
        }
    }
    
    private var sampleTextColorView: some View {
        VStack {
            SampleSectionTitleView(title: "2. 文本颜色", desc: "")
            Text("蓝色文字").foregroundColor(.blue)
            Text("自定义颜色/加粗")
                .bold()
                .foregroundColor(Color(UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)))
            Text("自定义资源颜色/倾斜")
                .italic()
                .foregroundColor(Color(R.color.custom_color()!))
            // 多语言版本的字符串，建议采用下划线的方式进行多语言配置
            Text(NSLocalizedString("hello_there", comment: ""))
        }
    }
    
    private var sampleTextSizeView: some View {
        VStack {
            SampleSectionTitleView(title: "3. 文本大小和粗细", desc: "")
            ScrollView(.horizontal) {
                HStack {
                    VStack {
                        Text("字体(.largeTitle)").font(.largeTitle)
                        Text("字体(.title)").font(.title)
                        Text("字体(.title2)").font(.title2)
                        Text("字体(.title3)").font(.title3)
                        Text("字体(.headline)").font(.headline)
                        Text("字体(.subheadline)").font(.subheadline)
                        Text("字体(.footnote)").font(.footnote)
                        Text("字体(.caption)").font(.caption)
                        Text("字体(.caption2)").font(.caption2)
                        Text("字体(.callout)").font(.callout)
                    }
                    VStack {
                        Text("字体(10f)").font(.system(size: 10))
                        Text("字体(12f)").font(.system(size: 12))
                        Text("字体(14f)").font(.system(size: 14))
                        Text("字体(16f)").font(.system(size: 16))
                        Text("字体(18f)").font(.system(size: 18))
                        Text("字体(20f)").font(.system(size: 20))
                        Text("字体(22f)").font(.system(size: 22))
                        Text("字体(24f)").font(.system(size: 24))
                        Text("字体(26f)").font(.system(size: 26))
                        Text("字体(28f)").font(.system(size: 28))
                    }
                    VStack {
                        Text("大小(.regular)").fontWeight(.regular)
                        Text("大小(.medium)").fontWeight(.medium)
                        Text("大小(.bold)").fontWeight(.bold)
                        Text("大小(.heavy)").fontWeight(.heavy)
                        Text("大小(.light)").fontWeight(.light)
                    }
                }
            }
        }
    }
    
    private var sampleTextEffectView: some View {
        VStack {
            SampleSectionTitleView(title: "4. 文本效果", desc: "")
            Group {
                Text("普通的背影效果")
                    .shadow(color: .black, radius: 1, x: 3, y: 3)
                Text(".shadow(color: .black, radius: 1, x: 3, y: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("较强的背影效果")
                    .shadow(color: .black, radius: 2, x: 3, y: 3)
                Text(".shadow(color: .black, radius: 2, x: 3, y: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("模糊效果").blur(radius: 3)
                Text(".blur(radius: 3)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("横划效果").strikethrough()
                Text(".strikethrough()").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("边框效果")
                    .border(.black, width: 2)
                Text(".border(.black, width: 2)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("边框+填充效果")
                    .padding(5).border(.black, width: 2)
                Text(".padding(5).border(.black, width: 2)").font(.system(size: 14)).foregroundColor(.gray)
            }
            Group {
                Text("边框+填充效果")
                    .border(.black, width: 2).padding(5).border(.black, width: 2)
                Text(".border(.black, width: 2).padding(5).border(.black, width: 2)").font(.system(size: 14)).foregroundColor(.gray)
            }
        }
    }
    
    private var sampleLinkView: some View {
        VStack {
            SampleSectionTitleView(title: "5. 链接 Link 和自定义点击事件", desc: "")
            Link(destination: URL(string: "https://www.baidu.com")!) {
                HStack {
                    Image(uiImage: R.image.christmas_star()!)
                    Text("这个一个跳转到网址的链接")
                }
            }
            Text("文本点击事件（带下划线）: \(self.index)").underline().onTapGesture {
                self.index = self.index + 1
            }
            Text("文本点击事件（自定义下划线）: \(self.index)").underline(true, color: .black).onTapGesture {
                self.index = self.index + 1
            }
        }
    }
    
    private var sampleTextWrapView: some View {
        VStack {
            SampleSectionTitleView(title: "6. 多行文本折叠", desc: "")
            Text(Consts.longText).lineLimit(2)
        }
    }
    
    private var sampleTextComplexView: some View {
        VStack {
            SampleSectionTitleView(title: "7. 图文混排")
            let message = Image(systemName: "message.badge.filled.fill")
                .renderingMode(.original)
            let wifi = Image(systemName: "wifi")
            let animatableWifi: Image = Image(systemName: "wifi")
            Text("Test").foregroundColor(.red)
            + Text(message).font(.title)
            + Text("文字与 SF Symbols 混排。\(wifi) Text 会将插值图片视作文字的一部分。")
            + Text(animatableWifi).foregroundColor(.blue).underline()
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                sampleMarqueeLabelView
                sampleTextColorView
                sampleTextSizeView
                sampleTextEffectView
                sampleLinkView
                sampleTextWrapView
                sampleTextComplexView
            }.padding(15)
        }.navigationTitle("文本示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct MarqueeLabelView: UIViewRepresentable {

    @Binding var text: String

    class Coordinator: NSObject {
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> MarqueeLabel {
        let marqueeLabel = MarqueeLabel()
        marqueeLabel.type = .leftRight
        marqueeLabel.speed = .duration(10)
        marqueeLabel.numberOfLines = 1
        return marqueeLabel
    }
    
    func updateUIView(_ uiView: MarqueeLabel, context: Context) {
        uiView.textAlignment = .center
        uiView.text = text
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        uiView.restartLabel()
    }
}

struct TextViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextDemoView()
            .environment(\.locale, .init(identifier: "zh-Hans"))
    }
}
