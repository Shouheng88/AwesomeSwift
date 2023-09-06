//
//  KV.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import Foundation

/// 键值对
struct KV {
    
    static let def = UserDefaults.standard

    @UserDefault(key: KV.Keys.testStringStorage, defaultValue: "")
    static var testStringValue: String
    
    public enum Keys {
        static let testStringStorage = "__test_kv_string"
    }
}

/// 一种封装思路：使用属性装饰，做 AOP，内部存取键值对
@propertyWrapper
struct UserDefault<Value> {

    let key: String

    let defaultValue: Value

    var container: UserDefaults = KV.def

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
