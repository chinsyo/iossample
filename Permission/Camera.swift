//
//  Camera.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import AVFoundation

internal extension Permission {
    var statusCamera: PermissionStatus {
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch status {
        case .Authorized:           return .Authorized
        case .Restricted, .Denied:  return .Denied
        case .NotDetermined:        return .NotDetermined
        }
    }
    
    func requestCamera(callback: Callback) {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) { _ in
            callback(self.statusCamera)
        }
    }
}