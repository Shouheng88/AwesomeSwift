//
//  TextViewDemo.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/10.
//

import SwiftUI

struct TextDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                // vstatck 超出 10 个就会报错。。。
                Group {
                    Text("文字蓝色").foregroundColor(.blue)
                    Text("自定义颜色/加粗").bold().foregroundColor(Color(UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)))
                    Text("自定义资源颜色/倾斜/italic").italic().foregroundColor(Color("customColor"))
                    HStack {
                        Text("背影").shadow(color: .black, radius: 1, x: 3, y: 3)
                        Text("背影").shadow(color: .black, radius: 2, x: 3, y: 3)
                    }
                }.border(.blue, width: 1) // group 上添加的属性会作用到内部的每一个控件上
                VStack {
                    HStack {
                        Text("大小(.regular)").fontWeight(.regular)
                        Text("大小(.medium)").fontWeight(.medium)
                    }
                    HStack {
                        Text("大小(.bold)").fontWeight(.bold)
                        Text("大小(.heavy)").fontWeight(.heavy)
                    }
                    HStack {
                        Text("大小(.light)").fontWeight(.light)
                    }
                }
                VStack {
                    HStack {
                        Text("字体(.largeTitle)").font(.largeTitle)
                        Text("字体(.title)").font(.title)
                    }
                    HStack {
                        Text("字体(.title2)").font(.title2)
                        Text("字体(.title3)").font(.title3)
                    }
                    HStack {
                        Text("字体(.headline)").font(.headline)
                        Text("字体(.subheadline)").font(.subheadline)
                    }
                    HStack {
                        Text("字体(.footnote)").font(.footnote)
                        Text("字体(.caption)").font(.caption)
                    }
                    HStack {
                        Text("字体(.caption2)").font(.caption2)
                        Text("字体(.callout)").font(.callout)
                    }
                    HStack {
                        Text("字体(10f)").font(.system(size: 10))
                        Text("字体(12f)").font(.system(size: 12))
                    }
                    HStack {
                        Text("字体(14f)").font(.system(size: 14))
                        Text("字体(16f)").font(.system(size: 16))
                    }
                    HStack {
                        Text("字体(18f)").font(.system(size: 18))
                        Text("字体(20f)").font(.system(size: 20))
                    }
                }
                Group {
                    Text("www.baidu.com").underline().onTapGesture {
                        print("baidu clicked")
                    }
                    Text("www.baidu.com").underline(true, color: .black).onTapGesture {
                        print("baidu clicked")
                    }
                    HStack {
                        Text("模糊").blur(radius: 3)
                        Text("横划").strikethrough()
                        Text("边框").border(.black, width: 2)
                        Text("边框").padding(5).border(.black, width: 2)
                    }
                    Text("一个超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超级长的文案")
                    Text("一个超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超超级长的文案").lineLimit(2)
                }
            }
        }
    }
}

struct TextViewDemo_Previews: PreviewProvider {
    static var previews: some View {
        TextDemoView()
    }
}
