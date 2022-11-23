//
//  LaunchPhonePageDemo.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI

struct LaunchPhonePageDemo: View {
    var body: some View {
        VStack {
            Text("Open App Settings")
                .frame(height: 40)
                .onTapGesture {
                    openAppSpecificSettings()
                }
        }
    }
    
    // https://stackoverflow.com/a/52103305/1477298
    private func openAppSpecificSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            return
        }

        let optionsKeyDictionary = [UIApplication.OpenExternalURLOptionsKey(rawValue: "universalLinksOnly"): NSNumber(value: true)]
        UIApplication.shared.open(url, options: optionsKeyDictionary, completionHandler: nil)
    }
}

struct LaunchPhonePageDemo_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPhonePageDemo()
    }
}
