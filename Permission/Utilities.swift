//
//  Utilities.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

internal let Application = UIApplication.sharedApplication()
internal let Defaults = NSUserDefaults.standardUserDefaults()
internal let NotificationCenter = NSNotificationCenter.defaultCenter()

extension UIApplication {
    var rootViewController: UIViewController? {
        let root = delegate?.window??.rootViewController
        return root?.presentedViewController ?? root
    }
}

extension UIControlState: Hashable {
    public var hashValue: Int {
        return Int(rawValue)
    }
}

internal extension String {
    static let nsLocationWhenInUseUsageDescription = "NSLocationWhenInUseUsageDescription"
    static let nsLocationAlwaysUsageDescription = "NSLocationAlwaysUsageDecription"
    static let requestedNotifications = "sorry_requestedNotifications"
    static let requestedLocationAlways = "sorry_requestedLocationAlways"
    static let requestedBluetooth = "sorry_requestedBluetooth"
}

internal extension Selector {
    
}

extension NSUserDefaults {
    var requestedLocationAlways: Bool {
        get {
            return boolForKey(.requestedLocationAlways)
        }
        
        set {
            setBool(newValue, forKey: .requestedLocationAlways)
            synchronize()
        }
    }
    
    var requestedNotifications: Bool {
        get {
            return boolForKey(.requestedNotifications)
        }
        set {
            setBool(newValue, forKey: .requestedNotifications)
            synchronize()
        }
    }
    
    var requestedMotion: Bool {
        get {
            return boolForKey(.requestedMotion)
        }
        set {
            setBool(newValue, forKey: .requestedMotion)
            synchronize()
        }
    }
    
    var requestedBluetooth: Bool {
        get {
            return boolForKey(.requestedBluetooth)
        }
        set {
            setBool(newValue, forKey: .requestedBluetooth)
            synchronize()
        }
    }
}

struct Queue {
    static func main(block: dispatch_block_t) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    
    static func main(after seconds: Double, block: dispatch_block_t) {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue(), block)
    }
}

extension NSOperationQueue {
    convenience init(_ qualityOfService: NSQualityOfService) {
        self.init()
        self.qualityOfService = qualityOfService
    }
}