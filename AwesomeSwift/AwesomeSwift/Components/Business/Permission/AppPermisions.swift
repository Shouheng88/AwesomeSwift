//
//  AppPermisions.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import Foundation
import Contacts
import CoreLocation

// 需要在 xcode info 中添加 “Privacy - Contacts Usage Description”
struct ContactsPermission {
    
    static var authorizationStatus: CNAuthorizationStatus {
        CNContactStore.authorizationStatus(for: .contacts)
    }

    static func request() {
        guard authorizationStatus != .authorized else { return }
        CNContactStore().requestAccess(for: .contacts) { (_, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}

// 需要在 xcode info 中添加 "Privacy - Location Usage Description"
struct LocationPermission {
    
    static var authorizationStatus: CLAuthorizationStatus {
        CLLocationManager().authorizationStatus
    }

    static var isAuthorized: Bool {
        authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }

    static func request() {
        guard isAuthorized else {
            print("Already Authorized!")
            return
        }
        CLLocationManager().requestWhenInUseAuthorization()
    }
}

struct AppPermissions {
    
    static var isAllAuthorized: Bool {
        ContactsPermission.authorizationStatus == .authorized && LocationPermission.isAuthorized
    }

    static func request() {
        ContactsPermission.request()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            LocationPermission.request()
        }
    }
}
