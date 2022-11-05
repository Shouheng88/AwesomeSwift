//
//  Project.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/1.
//

import Foundation
import HandyJSON

/// 项目
struct Project: Codable, Equatable, Identifiable, HandyJSON {
    var id = UUID()
    var title: String?
    var niceShareDate: String?
    var link: String?
    var author: String?
    var envelopePic: String?
    var shareDate: Double?
    
    func shareDateStr() -> String {
        let date = Date(timeIntervalSince1970: shareDate ?? 0)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct ProjectResponse: HandyJSON {
    var datas: [Project]?
}

class BaseResponse<T: HandyJSON>: HandyJSON {
    var errorCode: Int? // 服务返回码
    var errorMsg: String?
    var data: T?
    
    public required init() {}
}
