//
//  AppInfoDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI

struct AppInfoDemoView: View {

    private var uiid = UIDevice.current.identifierForVendor?.uuidString ?? ""
    
    private var appInfoView: some View {
        VStack {
            Text("App Name: \(AppInfoUtils.appName)")
            Text("App Version: \(AppInfoUtils.appVersion)")
            Text("App Build: \(AppInfoUtils.appBuild)")
            Text("App Build Date: \(AppInfoUtils.getDateString(date: AppInfoUtils.buildDate))")
        }.padding(.top, 10)
    }
    
    private var deviceInfoView: some View {
        VStack {
            Text("Device name: \(UIDevice.current.name)")
            Text("Device model: \(UIDevice.current.model)")
            Text("Device system version: \(UIDevice.current.systemVersion)")
            Text("Device system name: \(UIDevice.current.systemName)")
            Text("Device localized model: \(UIDevice.current.localizedModel)")
            Text("Device uiid: \(uiid)")
            Text("Device battery level: \(UIDevice.current.batteryLevel)")
            Text("Device battery state: \(getBatteryStateString())")
            Text("Device orientation: \(getOrientationString())")
        }
    }
    
    private var screenInfoView: some View {
        VStack {
            Text("Screen width: \(UIScreen.main.bounds.width)")
            Text("Screen width: \(UIScreen.main.bounds.height)")
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
    
    var body: some View {
        VStack {
            appInfoView.padding(.vertical, 10)
            screenInfoView.padding(.vertical, 10)
            deviceInfoView.padding(.vertical, 10)
        }
    }
}

struct AppInfoDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AppInfoDemoView()
    }
}
