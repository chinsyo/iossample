//
//  LocationAlways.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import CoreLocation

internal extension Permission {
    var statusLocationAlways: PermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else {
            return .Disabled
        }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .AuthorizedAlways:
            return .Authorized
        case .AuthorizedWhenInUse: return Defaults.requestedLocationAlways ? .Denied : .NotDetermined
        case .NotDetermined: return .NotDetermined
        case .Restricted, .Denied: return .Denied
        }
    }
    
    func requestLocationAlways(callback: Callback) {
        guard let _ = NSBundle.mainBundle().objectForInfoDictionaryKey(.nsLocationAlwaysUsageDescription) else {
            print("WARNING: \(.nsLocationAlwaysUsageDescription) not found in Info.plist")
            return
        }
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            Defaults.requestedLocationAlways = true
        }
        
        LocationManager.request(self)
    }
}
