//
//  AwesomeWidget.swift
//  AwesomeWidget
//
//  Created by 王守恒 on 2022/11/25.
//

import WidgetKit
import SwiftUI
import Intents

/// Widget 创建方式：
/// File > New > Target > Widget Extension
/// 输入名字
/// 点击 Finish 完成

private struct Provider: IntentTimelineProvider {

    /// widget 第一次渲染的时候使用 placeholder
    func placeholder(in context: Context) -> SimpleEntry {
        print("placeholder \(Date().format(format: "HH:mm:ss"))")
        return SimpleEntry(date: Date(), configuration: ConfigurationIntent(), testString: "placeholder")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, testString: "getSnapshot")
        print("getSnapshot \(Date().format(format: "HH:mm:ss"))")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        completion(getTimelineUpdate1Second(for: configuration))
//        completion(getTimeLineFuture30Seconds(for: configuration))
    }
    
    /// 设置未来的更新时间，比如设置 30 个未来的 30 秒，就表示未来 30 秒会更新，更新完就完了
    private func getTimeLineFuture30Seconds(for configuration: ConfigurationIntent) -> Timeline<Entry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 30 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, testString: "getTimeline [\(hourOffset)]")
            entries.append(entry)
        }
        print("getTimeline \(currentDate.format(format: "HH:mm:ss"))")
        let timeline = Timeline(entries: entries, policy: .atEnd)
        return timeline
    }
    
    private func getTimelineUpdate1Second(for configuration: ConfigurationIntent) -> Timeline<Entry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        let nextDate = Calendar.current.date(byAdding: .second, value: 10, to: currentDate)!
        let entry = SimpleEntry(date: currentDate, configuration: configuration, testString: "getTimeline")
        entries.append(entry)
        let timeline = Timeline(entries: entries, policy: .after(nextDate))
        return timeline
    }
}

private struct SimpleEntry: TimelineEntry {
    // 渲染 widget 的时间
    let date: Date
    let configuration: ConfigurationIntent
    // 给一个测试的属性
    var testString: String = "test"
}

struct AwesomeWidgetEntryView : View {
    
    @Environment(\.widgetFamily) var family
    @Environment(\.colorScheme) var colorScheme

    fileprivate var entry: Provider.Entry
    
    @State private var tip: String = ""
    
    private var deeplinkURL: URL {
        URL(string: "widget-DeepLinkWidget://widgetFamily/\(family)")!
    }

    var body: some View {
        ZStack {
            backgroundColor
            VStack {
                // 这里根据 family 属性可以判断当前 widget 的尺寸
                switch family {
                case .systemSmall:
                    Text("systemSmall").widgetURL(deeplinkURL)
                case .systemMedium:
                    Text("systemMedium")
                case .systemLarge, .systemExtraLarge:
                    Text("systemLarge/systemExtraLarge")
                // 只要处理上面三种就可以了！！下面的类型不用管
                case .accessoryCircular:
                    Text("accessoryCircular")
                case .accessoryRectangular:
                    Text("accessoryRectangular")
                case .accessoryInline:
                    Text("accessoryInline")
                @unknown default:
                    Text("unknown")
                }

                Text(entry.date.format(format: "HH:mm:ss"))
                    .onTapGesture {
                        self.tip = "clicked time text"
                    }
                Text(entry.testString)
                    .onTapGesture {
                        self.tip = "clicked test string"
                    }
                Text(tip)
                    .onTapGesture {
                        self.tip = "clicked tip text"
                    }
            }.onTapGesture {
                self.tip = "cliked body"
            }
        }
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .red : .orange
    }
}

extension Date {
    func format(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate(format)
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter.string(from: self)
    }
}

// 定义小组件
struct AwesomeWidget: Widget {
    let kind: String = "AwesomeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            // 添加一个打印函数主要查看 content 回调的调用情况
            print("[content]--\(entry.testString)")
            return AwesomeWidgetEntryView(entry: entry)
        }
        // 定义名字和副标题
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        // 支持的卡片样式大小
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct AwesomeWidget_Previews: PreviewProvider {
    static var previews: some View {
        AwesomeWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

