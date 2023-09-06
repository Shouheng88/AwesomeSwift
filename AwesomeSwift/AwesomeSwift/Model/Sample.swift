//
//  Sample.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2023/9/4.
//

import Foundation
import SwiftUI

/// 示例条目
struct SampleItem: Identifiable {
    
    var id: UUID = UUID()
    
    var name: String
    
    var destination: any View
}

/// 示例分组
class SampleGroup: Identifiable {
    
    var id: UUID = UUID()
        
    var items: [SampleItem] = []
    
    /// TODO: 使用结构体的时候下面的方法将会无效
    func addItem(item: SampleItem) {
        self.items.append(item)
    }
}

struct SampleData {
    
    private static let items: [SampleItem] = [
        SampleItem(name: "文本", destination: TextDemoView()),
        SampleItem(name: "按钮", destination: ButtonDemoView()),
        SampleItem(name: "输入框", destination: TextFieldDemoView()),
        SampleItem(name: "图片展示", destination: ImageDemoView()),
        SampleItem(name: "图片选择", destination: ImagePickDemoView()),
        SampleItem(name: "表单", destination: FormDemoView()),
        SampleItem(name: "手势", destination: GestureDemoView()),
        SampleItem(name: "动画", destination: AnimationDemoView()),
        SampleItem(name: "布局", destination: LayoutDemoView()),
        SampleItem(name: "弹窗", destination: PopupDemoView()),
        SampleItem(name: "提示*", destination: AlertDemoView()),
        SampleItem(name: "TAB页面", destination: TabPageDemoView()),
        SampleItem(name: "底部导航栏页面框架", destination: BottomTabDemoView()),
        SampleItem(name: "顶部TAB页面框架", destination: SegmentedViewDemo()),
        SampleItem(name: "全屏页面", destination: ImmersiveView()),
        SampleItem(name: "软键盘", destination: KeyboardDemoView()),
        SampleItem(name: "列表", destination: ListSampleView()),
        SampleItem(name: "更新提示*", destination: WhatsNewKitView()),
        SampleItem(name: "通知*", destination: NotificationBannerView()),
        SampleItem(name: "下拉刷新", destination: PullToRefreshViewDemo()),
        SampleItem(name: "键值对存储", destination: UserDefaultsDemoView()),
        SampleItem(name: "WebDAV存储", destination: WebDAVDemoView()),
        SampleItem(name: "文件", destination: FileDemoView()),
        SampleItem(name: "文件选择", destination: DocumentPickerDemoView()),
        SampleItem(name: "Environment示例", destination: EnvironmentDemoView()),
        SampleItem(name: "APP信息", destination: AppInfoDemoView()),
        SampleItem(name: "音频播放", destination: AudioPlayDemoView()),
        SampleItem(name: "SQLite", destination: SqlLiteDemoView()),
        SampleItem(name: "换图标", destination: ChangeIconDemoView()),
        SampleItem(name: "分享", destination: ShareDemoView()),
        SampleItem(name: "发邮件", destination: EmailDemoView()),
        SampleItem(name: "打开页面", destination: LaunchPhonePageDemo()),
        SampleItem(name: "申请权限", destination: PermissionDemoView()),
        SampleItem(name: "切换主题", destination: ThemeDemoView()),
        SampleItem(name: "玩安卓", destination: ProjectList()),
        SampleItem(name: "AI视觉", destination: VisionDemoView()),
    ]
    
    /// 获取示例数据
    static func getSamples() -> [SampleGroup] {
        var groups: [SampleGroup] = []
        var index = 0
        var group: SampleGroup? = nil
        for item in items {
            if index % 3 == 0 {
                group = SampleGroup()
                groups.append(group!)
            }
            group?.addItem(item: item)
            index = index + 1
        }
        return groups
    }
}
