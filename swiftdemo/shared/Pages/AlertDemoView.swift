//
//  AlertDemoView.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/9/16.
//

import SwiftUI

struct AlertDemoView: View {
    
    @State var showAlert: Bool = false
    
    @State var showSheet: Bool = false
    
    private var sheet: ActionSheet {
        return ActionSheet(title: Text("Shit"), message: Text("Message"), buttons: [
            .destructive(Text("Fuckkkkkkkkk!"), action: {
                print("you clicked fuck!")
            }),
            .destructive(Text("Shit"), action: {
                print("you clicked shit!")
            }),
            .default(Text("Damn it!"), action: {
                print("You cliked damn it!!")
            }),
            .cancel(Text("Cannnnnnncel"), action: {
                print("You want to cancel me???")
            })
        ])
    }
    
    var body: some View {
        VStack {
            Button(action: {
                print("clicked alert")
                self.showAlert = true
            }, label: {
                Text("Show Alert").foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-30, height: 40)
            }).alert(isPresented: $showAlert, content: {
                Alert(title: Text("title"),
                      message: Text("message"),
                      primaryButton: .destructive(Text("primary")),
                      secondaryButton: .cancel())
            }).background(.blue) // 显示对话框
            
            Button(action: {
                self.showSheet = true
            }, label: {
                Text("Show Sheet").foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width-30, height: 40)
            }).actionSheet(isPresented: $showSheet, content: {sheet})
                .background(.orange)
        }
    }
}

struct AlertDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AlertDemoView()
    }
}
