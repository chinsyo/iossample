//
//  Photos.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import Photos

internal extension Permission {
    var statusPhothos: PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .Authorized:           return .Authorized
        case .Restricted, .Denied:  return .Denied
        case .NotDetermined:        return .NotDetermined
        }
    }
    
    func requestPhotos(callback: Callback) {
        PHPhotoLibrary.requestAuthorization{ _ in
            callback(self.statusPhothos)
        }
    }
}
