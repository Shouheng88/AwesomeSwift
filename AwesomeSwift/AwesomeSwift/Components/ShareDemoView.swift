//
//  ShareDemoView.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/24.
//

import SwiftUI

struct ShareDemoView: View {
    
    private let link = URL(string: "https://www.fullstack.fan")!
    
    var body: some View {
        VStack(spacing: 20) {
            if #available(iOS 16.0, *) {
                ShareLink(item: link)
                ShareLink("Share link", item: link)
                ShareLink(item: link) {
                    Label("Share link", systemImage: "lasso")
                }
                ShareLink(item: link, message: Text("Hoooollow!"))
                ShareLink(
                    item: link,
                    preview: SharePreview(
                        "Switzerland's flag: it's a big plus.",
                        image: Image(systemName: "plus")
                    )
                )
            } else {
                EmptyView()
            }
            
            Button("Share Link", action: {
                let activityController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
            })
            
            Button("Share text", action: {
                let activityController = UIActivityViewController(activityItems: ["This is the sample text to share!"], applicationActivities: nil)
//                activityController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
                // exclude some activity types from the list (optional)
                activityController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
                UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
            })
            
            Button("Share Image", action: {
                let activityController = UIActivityViewController(activityItems: [R.image.the_soup()!], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
            })
        }
    }
}

struct ShareDemoView_Previews: PreviewProvider {
    static var previews: some View {
        ShareDemoView()
    }
}
