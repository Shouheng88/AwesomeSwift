//
//  AppPermisions.swift
//  AwesomeSwift
//
//  Created by 王守恒 on 2022/11/13.
//

import Foundation
import Contacts
import CoreLocation
import PhotosUI
import AVFoundation

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

// 权限：Privacy - Photo Library Usage Description
struct PhotoLibraryPermission {
    
    static var authorizationStatus: PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus()
    }

    static var authorizationStatusText: String {
        return textOfStatus(status: authorizationStatus)
    }

    private static func textOfStatus(status: PHAuthorizationStatus) -> String {
        switch status {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorized:
            return "authorized"
        case .limited:
            return "limited"
        @unknown default:
            return "@unknown"
        }
    }
    
    static func request() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { status in
            print("request status: \(textOfStatus(status: status))")
        })
    }
}

// 权限：Privacy - Camera Usage Description
struct CameraPermission {
    
    static var authorizationStatus: AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
    }
    
    static var authorizationStatusText: String {
        return textOfStatus(status: authorizationStatus)
    }
    
    private static func textOfStatus(status: AVAuthorizationStatus) -> String {
        switch status {
        case .notDetermined:
            return "notDetermined"
        case .restricted:
            return "restricted"
        case .denied:
            return "denied"
        case .authorized:
            return "authorized"
        @unknown default:
            return "@unknown"
        }
    }
    
    static func request() {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { ret in
            print("request status: \(ret)")
        })
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
