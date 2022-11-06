//
//  TextViewDemo.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI
import MarqueeLabel

struct TextDemoView: View {

    @State private var text = ""
    
    var colorSampleView: some View {
        Section(header: Text("文字颜色示例").sectionTitle()) {
            Text("蓝色文字").foregroundColor(.blue)
            Text("自定义颜色/加粗")
                .bold()
                .foregroundColor(Color(UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)))
            Text("自定义资源颜色/倾斜/italic")
                .italic()
                .foregroundColor(Color(R.color.custom_color()!))
            // 多语言版本的字符串，建议采用下划线的方式进行多语言配置
            Text(NSLocalizedString("hello_there", comment: ""))
        }.border(.blue, width: 1)
        // group 上添加的属性会作用到内部的每一个控件上
    }
    
    var textEffectSampleView: some View {
        Section(header: Text("文字效果示例").sectionTitle()) {
            Text("普通的背影效果")
                .shadow(color: .black, radius: 1, x: 3, y: 3)
            Text("较强的背影效果")
                .shadow(color: .black, radius: 2, x: 3, y: 3)
            Text("模糊效果")
                .blur(radius: 3)
            Text("横划效果")
                .strikethrough()
            Text("边框效果")
                .border(.black, width: 2)
            Text("边框+填充效果")
                .padding(5)
                .border(.black, width: 2)
            Text("边框+填充效果")
                .border(.black, width: 2)
                .padding(5)
                .border(.black, width: 2)
        }
    }
    
    var preDefinedFontSizeSampleView: some View {
        Section(header: Text("预定义字体示例").sectionTitle()) {
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
    }
    
    var textFontWeightSampleView: some View {
        Section(header: Text("字体 fontWeight 属性示例").sectionTitle()) {
            Text("大小(.regular)").fontWeight(.regular)
            Text("大小(.medium)").fontWeight(.medium)
            Text("大小(.bold)").fontWeight(.bold)
            Text("大小(.heavy)").fontWeight(.heavy)
            Text("大小(.light)").fontWeight(.light)
        }
    }
    
    var normalTextSizeSampleView: some View {
        Section(header: Text("指定文字大小").sectionTitle()) {
            Text("字体(10f)").font(.system(size: 10))
            Text("字体(12f)").font(.system(size: 12))
            Text("字体(14f)").font(.system(size: 14))
            Text("字体(16f)").font(.system(size: 16))
            Text("字体(18f)").font(.system(size: 18))
            Text("字体(20f)").font(.system(size: 20))
        }
    }
    
    var linkEffectSampleView: some View {
        Section(header: Text("链接示例").sectionTitle()) {
            Link(destination: URL(string: "https://www.baidu.com")!) {
                Text("Click me! I'm a link!")
            }
            Link(destination: URL(string: "https://www.baidu.com")!) {
                Image(uiImage: R.image.christmas_star()!)
            }
            Text("www.baidu.com").underline().onTapGesture {
                print("baidu clicked")
            }
            Text("www.baidu.com").underline(true, color: .black).onTapGesture {
                print("baidu clicked")
            }
        }
    }
    
    var textWrapSampleView: some View {
        Section(header: Text("文字折叠效果示例").sectionTitle()) {
            Text("The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value.")
            Spacer().frame(height: 10)
            Text("The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value.").lineLimit(2)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                MarqueeLabelView(text: self.$text)
//                    .frame(width: 300, height: 40)
                    .onAppear(perform: {
                        self.text = "The initializer call Celsius (37.0) is clear in its intent without the need for an argument label. It’s therefore appropriate to write this initializer as init (_ celsius: Double) so that it can be called by providing an unnamed Double value."
                    })
                colorSampleView
                preDefinedFontSizeSampleView
                textFontWeightSampleView
                normalTextSizeSampleView
                textEffectSampleView
                linkEffectSampleView
                textWrapSampleView
            }
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
