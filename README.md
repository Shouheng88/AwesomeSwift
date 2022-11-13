# AwesomeSwift -- SwiftUI 样板工程

## 1、简介

该项目用来演示 SwiftUI 的控件和各种功能组件的使用。

## 2、技术栈说明

### 2.1 依赖关系

该项目使用 CocoaPods 作为构建工具，目前使用的依赖有：

- R.swift：类似于 Android 的 R 文件，用来简化调用资源的方式
- Alamofire：网络请求
- HandyJSON：Json 格式数据解析
- Kingfisher：网络图片加载框架
- Then：语法糖，类似于 Kotlin 的 apply 等功能

### 2.2 控件示例



### 2.3 事件示例

- [onChange](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectList.swift)：用来监听某个 state 变更，可以用作控件内的通信
- 全局通信 Notification：可以用作不相互依赖的控件之间的通信
  - [post](AwesomeSwift/AwesomeSwift/Components/ButtonDemoView.swift)：发送端
  - [onReceive](AwesomeSwift/AwesomeSwift/ContentView.swift)：接收端
- Preference：子控件向父控件传递信息
  - [CustomPreference](AwesomeSwift/AwesomeSwift/Components/CustomPreference.swift):自定义 Preference
  - [CustomPreference 使用](AwesomeSwift/AwesomeSwift/Components/ButtonDemoView.swift)
- [@EnvironmentObject](AwesomeSwift/AwesomeSwift/Components/Business/Events/EnvironmentDemoView.swift)：父控件用来向子控件传参
- 

### 2.4 页面框架示例

### 2.5 综合实例

**MVVM 框架使用**

- [ViewModel](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectViewModel.swift)
- [View](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectList.swift)
- [Model](AwesomeSwift/AwesomeSwift/WanAndroid/Project.swift)

**网络请求**

[](AwesomeSwift/AwesomeSwift/WanAndroid/ProjectViewModel.swift)


