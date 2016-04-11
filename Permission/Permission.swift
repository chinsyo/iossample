//
//  Permission.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import Foundation

public typealias Callback = PermissionStatus -> Void

public class Permission: NSObject {
    
    public let type: PermissionType
    private init( _ type: PermissionType) {
        self.type = type
    }
    
    public static let Contacts = Permission(.Contacts)
    public static let LocationAlways = Permission(.LocationAlways)
    public static let LocationWhenInUse = Permission(.LocationWhenInUse)
    public static let Microphone = Permission(.Microphone)
    public static let Camera = Permission(.Camera)
    public static let Photos = Permission(.Photos)
    public static let Reminders = Permission(.Reminders)
    public static let Events = Permission(.Events)
    public static let Bluetooth = Permission(.Bluetooth)
    public static let Motion = Permission(.Motion)
    public static func Notifications(categories categories:Swift.Set<UIUserNotificationCategory>?) -> Permission {
        let permission = Permission(.Notifications)
        return permission
    }
    
    public var status: PermissionStatus {
        switch type {
        case .Contacts:
            return statusContacts
        case .LocationAlways:
            return statusLocationAlways
        case .LocationWhenInUse:
            return statusLocationWhenInUse
        case .Notifications:
            return statusNotifications
        case .Microphone:
            return statusMicrophone
        case .Camera
            return statusCamera
        case .Photos:
            return statusPhothos
        case .Reminders:
            return statusReminders
        case .Events:
            return statusEvents
        case .Bluetooth
            return statusBluetooth
        case .Motion:
            return statusMotion
        }
    }
    
    internal func callbacks(status:  PermissionStatus) {
        Queue.main {
            self.callback(status)
            self.permissionSets.forEach { $0.didRequestPermission(self) }
        }
    }
}

extension Permission {
    override public var description {
        return "\(type): \(status)"
    }
    
    internal var prettyDescription: String {
        switch type {
        case .LocationAlways, .LocationWhenInUse:
            return "Location"
        default:
            return String(type)
        }
    }
}