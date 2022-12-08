# AwesomeSwift -- SwiftUI 综合示例、样板工程

## 1、简介

该项目是在阅读了多个开源项目源码之后沉淀而成，用来演示 SwiftUI 的控件和各种功能组件的使用，同时包含了实际开发过程中可能使用到的各种必备的组件，比如 Lottie、RSwift、崩溃统计等等，适合想要学习 Swift 开发的的新手同学。

## 2、技术示范

该项目支持最低版本 iOS 为 14，使用 CocoaPods 作为构建工具。下面是范例清单。

### 2.1 SwiftUI 内置控件

- Text 的示范：[TextDemoView](AwesomeSwift/AwesomeSwift/Components/TextDemoView.swift)
  - Text：普通文本
  - Link：可以点击的链接
- 按钮的示范：[ButtonDemoView](AwesomeSwift/AwesomeSwift/Components/ButtonDemoView.swift)
  - Button：常规按钮以及常用的背景实现示范
  - Toggle：开闭按钮
  - Slider：滑块按钮
  - Stepper：步进器
  - NavigationLink：跳转按钮
- 输入框的示范：[TextFieldDemoView](AwesomeSwift/AwesomeSwift/Components/TextFieldDemoView.swift)
  - TextField：单行输入
  - TextEditor：多行输入
  - SecureField：密码输入
- 图片控件 Image 的示例：[ImageDemoView](AwesomeSwift/AwesomeSwift/Components/ImageDemoView.swift)
  - Image：使用 UIImage、系统内置图片、缩放技巧
  - 自定义形状：LinearGradient、RoundedRectangle、Capsule 和 Circle
- 表单的示例：[FormDemoView](AwesomeSwift/AwesomeSwift/Components/FormDemoView.swift)
- 对话框和弹出：[PopupDemoView](AwesomeSwift/AwesomeSwift/Components/PopupDemoView.swift)
  - ActionSheet：底部弹出的标准对话框
  - Alert：中间弹出的标准对话框
  - Popover：可自定义弹出浮层，但是会让底部对话框缩小
  - Picker：局部弹出的列表选择框，支持多种样式
  - DatePicker：日期和时间选择
- 动画的示例：[AnimationDemoView](AwesomeSwift/AwesomeSwift/Components/AnimationDemoView.swift)
  - DragGesture：手势拖动
  - withAnimation：淡入淡出等效果
  - simultaneousGesture：持续手势处理
  - highPriorityGesture：高优先级手势
  - ViewModifier：自定义变换
- 布局示例：[LayoutDemoView](AwesomeSwift/AwesomeSwift/Components/LayoutDemoView.swift)
  - 布局控件：ScrollView、HStack、VStack 和 ZStack
  - alignment：对齐属性
  - multilineTextAlignment：多行文本对齐属性
  - alignmentGuide：对齐属性微调
- SwiftUI 中使用 UIKit 控件示范：[SegmentedViewDemo](AwesomeSwift/AwesomeSwift/Components/SegmentedViewDemo.swift)
  - 继承 UIViewRepresentable 并实现 makeCoordinator、makeUIView 和 updateUIView 三个方法

### 2.2 开发必备的非官方控件

- 网络图加载示例：[ProjectRow](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectRow.swift)
  - 网络图加载细节非常多，比如缓存处理
  - 基于开源框架 [Kingfisher](https://github.com/onevcat/Kingfisher) 实现
- Lottie 动图示例：[ImageDemoView](AwesomeSwift/AwesomeSwift/Components/ImageDemoView.swift)
  - Lottie 在实现复杂动画时非常有用，是业界常用方案之一
  - 基于开源 Lottie 框架 [lottie-ios](https://github.com/airbnb/lottie-ios) 实现
  - 原框架基于 UIKit 开发，因此这里使用 [LottieView](AwesomeSwift/AwesomeSwift/Components/Business/Image/LottieView.swift) 将其包装为 SwiftUI 中可用的控件
- 自定义弹出覆层示例：[PopupDemoView](AwesomeSwift/AwesomeSwift/Components/PopupDemoView.swift)
  - 类似于 Android 的对话框弹出效果，但是不会导致底部页面大小和位置变化
- 更新内容弹窗示例：[WhatsNewKitView](AwesomeSwift/AwesomeSwift/Components/WhatsNewKitView.swift)
  - 基于开源项目 [WhatsNewKit](https://github.com/SvenTiigi/WhatsNewKit)
  - 非必需，可酌情使用
- 顶部和底部通知示例：[NotificationBannerView](AwesomeSwift/AwesomeSwift/Components/NotificationBannerView.swift)
  - 基于开源项目 [NotificationBanner](https://github.com/Daltron/NotificationBanner)
- 上拉和下拉刷新示例：[PullToRefreshViewDemo](AwesomeSwift/AwesomeSwift/Components/PullToRefreshViewDemo.swift)
  - 自定义框架 [PullToRefresh](AwesomeSwift/AwesomeSwift/Components/PullToRefresh)
- Toast 通知示例：[AlertDemoView](AwesomeSwift/AwesomeSwift/Components/Business/AlertDemoView.swift)
  - 基于开源项目 [AlertToast](https://github.com/elai950/AlertToast)

### 2.3 常用页面结构示例

- 顶部 Tab 切换代码，系统样式：[TabPageDemoView](AwesomeSwift/AwesomeSwift/Components/TabPageDemoView.swift)
- 底部 Navigation 嵌套顶部 Tab 样式：[TabDemoView](AwesomeSwift/AwesomeSwift/Components/TabDemoView.swift)
- 自定义顶部 Tab 的样式：[SegmentedViewDemo](AwesomeSwift/AwesomeSwift/Components/SegmentedViewDemo.swift)
- 翻页效果：[TabDemoView](AwesomeSwift/AwesomeSwift/Components/TabDemoView.swift)
  - 类似 Android ViewPager 样式
  - 自定义页面指示器 indicator
- 全屏、沉浸式页面：[ImmersiveView](AwesomeSwift/AwesomeSwift/Components/ImmersiveView.swift)
- 底部键盘监听和处理示例：[KeyboardDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Keyboard/KeyboardDemoView.swift)
- 列表示例：[ListSampleView](AwesomeSwift/AwesomeSwift/Components/Business/List/ListSampleView.swift)
  - 支持拖动和删除的列表：[OptionListView](AwesomeSwift/AwesomeSwift/Components/Business/List/OptionListView.swift)
  - 头部悬停的列表：[SectionListView](AwesomeSwift/AwesomeSwift/Components/Business/List/SectionListView.swift)
  - 自定义向左滑动列表：[SwipeListView](AwesomeSwift/AwesomeSwift/Components/Business/List/SwipeListView.swift)

### 2.4 常用业务和功能模块

- 动态修改应用的 icon：[ChangeIconDemoView](AwesomeSwift/AwesomeSwift/Components/ChangeIconDemoView.swift)
- 发送邮件示例：[EmailDemoView](AwesomeSwift/AwesomeSwift/Components/EmailDemoView.swift)
  - 实用系统内置页发送邮件
  - 通过 url 调用三方应用发送邮件
- 分享示例：[ShareDemoView](AwesomeSwift/AwesomeSwift/Components/ShareDemoView.swift)
  - 图片、链接、文本的分享
- 桌面小组件示例：[AwesomeWidget](AwesomeSwift/AwesomeWidget)
  - [ClockWidget](AwesomeSwift/AwesomeWidget/ClockWidget.swift)
  - [CountdownWidget](AwesomeSwift/AwesomeWidget/CountdownWidget.swift)
  - [MainWidget](AwesomeSwift/AwesomeWidget/MainWidget.swift)
  - [TimerWidget](AwesomeSwift/AwesomeWidget/TimerWidget.swift)
- 主题切换示例：[ThemeDemoView](AwesomeSwift/AwesomeSwift/Components/ThemeDemoView.swift)
- 权限获取示例：[PermissionDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Permission/PermissionDemoView.swift)
- 打开应用设置：[LaunchPhonePageDemo](AwesomeSwift/AwesomeSwift/Components/LaunchPhonePageDemo.swift)
- 外部打开网页：[LaunchPhonePageDemo](AwesomeSwift/AwesomeSwift/Components/LaunchPhonePageDemo.swift)
- 到应用商店评分：[LaunchPhonePageDemo](AwesomeSwift/AwesomeSwift/Components/LaunchPhonePageDemo.swift)
- 音频播放：[AudioPlayDemoView](AwesomeSwift/AwesomeSwift/Components/Business/AudioPlayDemoView.swift)
- AI 视觉：[VisionDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Vision/VisionDemoView.swift)
  - 文本识别：[DocScanDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Vision/DocScanDemoView.swift)
  - 扫描示例：[ScannerDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Vision/ScannerDemoView.swift)

### 2.5 数据存储和数据交互

**数据存储**

- 键值对存储示例：[StorageDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Storage/StorageDemoView.swift)
  - 基于 propertyWrapper 装饰器的封装示例：[KV](AwesomeSwift/AwesomeSwift/Components/Business/Storage/KV.swift)
- 文件存储示例：[FileDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Storage/FileDemoView.swift)
  - 系统存储路径展示
  - 基本的文件操作：写入、删除和创建目录等
- 数据库读写示例：[SqlLiteDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Sql/SqlLiteDemoView.swift)
  - 数据库基于 SQLite3 实现
  - 这里用了开源的 SQLite 框架 [SQLite.swift](https://github.com/stephencelis/SQLite.swift) 实现数据库的读写
- 文件选择示例：[DocumentPickerDemoView](AwesomeSwift/AwesomeSwift/Components/Business/FilePick/DocumentPickerDemoView.swift)
- 图片选择示例：[ImagePickDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Image/ImagePickDemoView.swift)

**数据交互**

- EnvironmentObject 数据共享示例：[EnvironmentDemoView](AwesomeSwift/AwesomeSwift/Components/Business/Events/EnvironmentDemoView.swift)
- 设备和应用信息获取示例：[AppInfoDemoView](AwesomeSwift/AwesomeSwift/Components/AppInfoDemoView.swift)
  - 屏幕、应用、设备和横屏等信息示例
- onPreferenceChange 示例：[ProjectList](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectList.swift)
- NotificationCenter 示例：[ButtonDemoView](AwesomeSwift/AwesomeSwift/Components/ButtonDemoView.swift)

### 2.6 环境和开发框架

*除了上述控件和页面框架等基本单元，作为一个成熟的产品，对应用的稳定性和开发的高效也是有要求的，这要求我们对开发环境进行基础的设置。所以，这里列举的是一些必要的可以提升开发效率和应用稳定性的工具。*

- [firebase-ios-sdk](https://github.com/firebase/firebase-ios-sdk)：应用崩溃监控，用来上报程序崩溃日志和进行简单的用户统计
- [R.swift](https://github.com/mac-cain13/R.swift)：用来以类似于 Android 的 R 文件的方式引用项目里的资源，比直接使用字符串应用的方式不容易出错
- [Then](https://github.com/devxoul/Then)：语法躺，类似于 Kotlin 的 apply 的效果，但是似乎只对 UIKit 有效
- [CocoaPods](https://github.com/CocoaPods/Specs)：项目的构建工具和依赖管理工具
- SwiftPackageManager：项目的依赖管理工具

### 2.7 综合示例

**WanAndroid 示例工程**

- 项目地址：[WanAndroid](AwesomeSwift/AwesomeSwift/WanAndroid)
- 该项目基于 [Alamofire](https://github.com/Alamofire/Alamofire) 实现网络请求
- 该项目基于 [HandyJSON](https://github.com/alibaba/HandyJSON) 实现 JSON 数据解析
- 该项目基于 [Kingfisher](https://github.com/onevcat/Kingfisher) 实现网络图片加载
- 该项目基于 MVVM 设计和开发

## License

```
Copyright (c) 2022-present WiSH

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
