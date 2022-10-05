//
//  BusinessDemo.swift
//  swiftdemo
//
//  Created by 王守恒 on 2022/10/5.
//

import SwiftUI
import MessageUI
import MapKit

struct BusinessDemo: View {
    var body: some View {
        VStack {
            Button(action: {
                sendEmail()
//                sendEmail2()
            }, label: {
                Text("Send Email")
            }).frame(height: 40)
            Button(action: {
                changeAppIcon()
            }, label: {
                Text("Change App Icon")
            }).frame(height: 40)
            Image("icon1").frame(width: 40, height: 40)
            Text("Storage value: \(UserDefaults.testStringValue)")
            Button(action: {
                UserDefaults.testStringValue = "helllo"
            }, label: {
                Text("Change UserDefaults Value")
            })
            MapWrapperView(location: Location(coordinate: CLLocationCoordinate2D()))
        }
    }
    
    /// 这种发送邮件的方式需要在 plist 当中注册 LSApplicationQueriesSchemes 信息
    /// xcode 13 当中注册的方式是 project-taget-info 然后新增条目即可
    private func sendEmail() {
        let receiver = "shouheng2020@gmail.com"
        let subject = "Email subject"
        let body = "Email body"
        let mailto = "mailto:\(receiver)?subject=\(subject)&body=\(body)"
        guard let escapedMailTo = mailto.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("failed to add coding")
            return
        }
        guard let url = URL(string: escapedMailTo) else {
            print("failed to build url")
            return
        }
        guard UIApplication.shared.canOpenURL(url) else {
            print("can not open url")
            return
        }
        UIApplication.shared.open(url, options: [.universalLinksOnly: false]) { (success) in
            print("sent email success[\(success)]")
        }
    }
    
    private func changeAppIcon() {
        // TODO: 无效！这里的 icon name 和资源是如何对应的？
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                UIApplication.shared.setAlternateIconName("icon1") { error in
                    if error != nil {
                        print("error !!!")
                    } else {
                        print("succeed")
                    }
                }
            } else {
                print("not support to change icon")
            }
        } else {
            print("not support to change icon: below 13.0")
        }
    }
    
//    private func sendEmail2() {
//        if MFMailComposeViewController.canSendMail() {
//            let controller = MFMailComposeViewController()
//            controller.mailComposeDelegate = self
//            controller.setSubject("subject")
//            controller.setToRecipients(["shouheng2020@gmail.com"])
//            controller.setMessageBody("mail body", isHTML: false)
//            self.present(controller, animated: true, completion: nil)
//        } else {
//            print("can't send email")
//        }
//    }
}

//class ViewController: UIViewController ,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //首先要判断设备具不具备发送邮件功能
//        if MFMailComposeViewController.canSendMail(){
//            let controller = MFMailComposeViewController()
//            //设置代理
//            controller.mailComposeDelegate = self
//            //设置主题
//            controller.setSubject("我是邮件标题")
//            //设置收件人
//            controller.setToRecipients(["a1@hangge.com","a2@hangge.com"])
//            //设置抄送人
//            controller.setCcRecipients(["b1@hangge.com","b2@hangge.com"])
//            //设置密送人
//            controller.setBccRecipients(["c1@hangge.com","c2@hangge.com"])
//
//            //添加图片附件
////            var path = NSBundle.mainBundle().pathForResource("hangge.png", ofType: "")
////            var myData = NSData(contentsOfFile: path!)
////            controller.addAttachmentData(myData, mimeType: "image/png", fileName: "swift.png")
//
//            //设置邮件正文内容（支持html）
//            controller.setMessageBody("我是邮件正文", isHTML: false)
//
//            //打开界面
//            self.present(controller, animated: true, completion: nil)
//        }else{
//            print("本设备不能发送邮件")
//        }
//    }
//
//    //发送邮件代理方法
//    func mailComposeController(controller: MFMailComposeViewController,
//        didFinishWithResult result: MFMailComposeResult, error: NSError?) {
//            controller.dismissViewControllerAnimated(true, completion: nil)
//
//            switch result.rawValue{
//                case MFMailComposeResultSent.rawValue:
//                    print("邮件已发送")
//                case MFMailComposeResultCancelled.rawValue:
//                    print("邮件已取消")
//                case MFMailComposeResultSaved.rawValue:
//                    print("邮件已保存")
//                case MFMailComposeResultFailed.rawValue:
//                    print("邮件发送失败")
//            default:
//                print("邮件没有发送")
//                break
//            }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//}

struct BusinessDemo_Previews: PreviewProvider {
    static var previews: some View {
        BusinessDemo()
    }
}
