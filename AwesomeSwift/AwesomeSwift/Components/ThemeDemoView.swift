//
//  ThemeDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/23.
//

import SwiftUI
import Rswift

struct ThemeDemoView: View {
    
    private var switchThemeView: some View {
        VStack {
            Button("Switch To Light", action: {
                UIApplication.shared.windows
                    .first { $0.isKeyWindow }?
                    .overrideUserInterfaceStyle = .light
            }).frame(height: 40)
            Button("Switch To Dark", action: {
                UIApplication.shared.windows
                    .first { $0.isKeyWindow }?
                    .overrideUserInterfaceStyle = .dark
            }).frame(height: 40)
            Button("Follow System", action: {
                UIApplication.shared.windows
                    .first { $0.isKeyWindow }?
                    .overrideUserInterfaceStyle = .unspecified
            }).frame(height: 40)
            HStack {
                Rectangle()
                    .fill(Color(R.color.dark_light_sample_color()!))
                    .frame(height: 30)
            }.padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
        }
    }
    
    private var uiInfoSampleView: some View {
        VStack {
            Text("UI Style: \(getTranslatedUIStyle())")
            Text("UI Idiom: \(getTranslatedUIIdiom())")
            Text("UI Layout: \(getTranslatedUILayout())")
        }
    }
    
    private func getTranslatedUIStyle() -> String {
        switch UITraitCollection.current.userInterfaceStyle {
            case .light:
                return "light";
            case .unspecified:
                return "unspecified";
            case .dark:
                return "dark";
            @unknown default:
                return "unknown";
        }
    }
    
    private func getTranslatedUIIdiom() -> String {
        switch UITraitCollection.current.userInterfaceIdiom {
            case .unspecified:
                return "unspecified";
            case .phone:
                return "phone";
            case .pad:
                return "pad";
            case .tv:
                return "tv";
            case .carPlay:
                return "carPlay";
            case .mac:
                return "mac";
            @unknown default:
                return "@unknown";
        }
    }
    
    private func getTranslatedUILayout() -> String {
        switch UITraitCollection.current.layoutDirection {
            case .unspecified:
                return "unspecified";
            case .leftToRight:
                return "leftToRight";
            case .rightToLeft:
                return "rightToLeft";
            @unknown default:
                return "@unknown";
        }
    }
    
    var body: some View {
        ScrollView(content: {
            VStack {
                uiInfoSampleView
                switchThemeView
            }
        })
    }
}

struct ThemeDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeDemoView()
    }
}
