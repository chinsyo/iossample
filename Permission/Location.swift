//
//  Location.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import CoreLocation

internal let LocationManager = CLLocationManager()

extension Permission: CLLocationManagerDelegate {
    public func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        callbacks(self.status)
    }
}

extension CLLocationManager {
    
}
