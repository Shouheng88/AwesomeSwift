//
//  AppInfoDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI

/// 应用信息示例
struct AppInfoDemoView: View {

    private var uiid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    private var appInfoView: some View {
        VStack {
            itemView(title: "App Name:", desc: AppInfoUtils.appName)
            itemView(title: "App Version:", desc: "\(AppInfoUtils.appVersion)")
            itemView(title: "App Build:", desc: "\(AppInfoUtils.appBuild)")
            itemView(title: "App Build Date:", desc: "\(AppInfoUtils.buildDate?.format(format: "yyyy-MM-dd HH:mm:ss") ?? "")")
        }.padding(.top, 10)
    }
    
    private var deviceInfoView: some View {
        VStack {
            itemView(title: "Device name:", desc: "\(UIDevice.current.name)")
            itemView(title: "Device model:", desc: "\(UIDevice.current.model)")
            itemView(title: "Device system version:", desc: "\(UIDevice.current.systemVersion)")
            itemView(title: "Device system name:", desc: "\(UIDevice.current.systemName)")
            itemView(title: "Device localized model:", desc: "\(UIDevice.current.localizedModel)")
            itemView(title: "Device uiid:", desc: "\(uiid)")
            itemView(title: "Device battery level:", desc: "\(UIDevice.current.batteryLevel)")
            itemView(title: "Device battery state:", desc: "\(getBatteryStateString())")
            itemView(title: "Device orientation:", desc: "\(getOrientationString())")
        }
    }
    
    private var screenInfoView: some View {
        VStack {
            itemView(title: "Screen width:", desc: "\(UIScreen.main.bounds.width)")
            itemView(title: "Screen width:", desc: "\(UIScreen.main.bounds.height)")
        }
    }
    
    private func getOrientationString() -> String {
        switch UIDevice.current.orientation {
        case .unknown:
            return "unknown"
        case .portrait:
            return "portrait"
        case .portraitUpsideDown:
            return "portraitUpsideDown"
        case .landscapeLeft:
            return "landscapeLeft"
        case .landscapeRight:
            return "landscapeRight"
        case .faceUp:
            return "faceUp"
        case .faceDown:
            return "faceDown"
        @unknown default:
            return "@unknown"
        }
    }
    
    private func getBatteryStateString() -> String {
        switch UIDevice.current.batteryState {
        case .unknown:
            return "unknown"
        case .unplugged:
            return "unplugged"
        case .charging:
            return "charging"
        case .full:
            return "full"
        @unknown default:
            return "@unknown"
        }
    }
    
    private func itemView(title: String, desc: String) -> AnyView {
        return AnyView(HStack {
            Text(title)
                .frame(width: (UIScreen.main.bounds.width - 40)/2, alignment: .trailing)
            Spacer()
            Text(desc)
                .frame(width: (UIScreen.main.bounds.width - 40)/2, alignment: .leading)
        })
    }
    
    var body: some View {
        ZStack {
            VStack {
                appInfoView.padding(.vertical, 10)
                screenInfoView.padding(.vertical, 10)
                deviceInfoView.padding(.vertical, 10)
            }.padding(15)
        }.navigationTitle("应用信息示例").navigationBarTitleDisplayMode(.inline)
    }
}

struct AppInfoDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoDemoView()
    }
}
