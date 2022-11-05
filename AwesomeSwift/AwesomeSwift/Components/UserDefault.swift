//
//  UserDefault.swift
//  swiftdemo (iOS)
//
//  Created by 王守恒 on 2022/10/5.
//

import Foundation

// TODO: 这种实践方式并不好，不要随意拓展预定义类
extension UserDefaults {

    // 可以自定义一个存储空间或者使用 standard
//    static let groupUserDefaults = UserDefaults(suiteName: "me.shouheng.sample")!
    static let groupUserDefaults = UserDefaults.standard

    @UserDefault(key: UserDefaults.Keys.testStringStorage, defaultValue: "")
    static var testStringValue: String
    
    public enum Keys {
        static let testStringStorage = "the_string_type_storage"
    }
}

// 一种封装思路：使用属性装饰，做 AOP，内部存取键值对
@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = UserDefaults.groupUserDefaults

    // TODO: 能否在这里监听值的变化？
    var wrappedValue: Value {
        get {
            container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }

    var projectedValue: UserDefault<Value> {
        self
    }
}
