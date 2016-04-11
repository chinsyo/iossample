//
//  Events.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import EventKit

internal extension Permission {
    var statusEvents: PermissionStatus {
        let status = EKEventStore.authorizationStatusForEntityType(.Event)
        switch status {
        case .Authorized:           return .Authorized
        case .Restricted, .Denied:  return .Denied
        case .NotDetermined:        return .NotDetermined
        }
    }
    
    func requestEvents(callback: Callback) -> Void {
        EKEventStore().requestAccessToEntityType(.Event) { _, _ in
            callback(self.statusEvents)
        }
    }
}
