//
//  Reminders.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import EventKit

internal extension Permission {
    var statusReminders: PermissionStatus {
        let status = EKEventStore.authorizationStatusForEntityType(.Reminder)
        switch status {
        case .Authorized:   return .Authorized
        case .Restricted, .Denied: return .Denied
        case .NotDetermined: return .NotDetermined
        }
    }
    
    func requestReminders(callback: Callback) {
        EKEventStore().requestAccessToEntityType(.Reminder) { _, _ in
            callback(self.statusReminders)
        }
    }
}
