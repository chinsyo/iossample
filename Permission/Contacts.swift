//
//  Contacts.swift
//  Permission
//
//  Created by Chinsyo on 16/4/7.
//  Copyright © 2016年 Chinsyo. All rights reserved.
//

import AddressBook
import Contacts

internal extension Permission {
    var statusContacts: PermissionStatus {
        if #available(iOS 9.0, *) {
            let status = CNContactStore.authorizationStatusForEntityType(.Contacts)
            switch status {
            case .Authorized:           return .Authorized
            case .Restricted, .Denied:  return .Denied
            case .NotDetermined:        return .NotDetermined
            }
        } else {
            let status = ABAddressBookGetAuthorizationStatus()
            switch status {
            case .Authorized:           return .Authorized
            case .Restricted, .Denied:  return .Denied
            case .NotDetermined:        return .NotDetermined
            }
        }
    }
    
    func requestContacts(callback: Callback) {
        if #available(iOS 9.0, *) {
            CNContactStore().requestAccessForEntityType(.Contacts) { _, _ in
                callback(self.statusContacts)
            }
        } else {
            ABAddressBookRequestAccessWithCompletion(nil) { _, _ in
                callback(self.statusContacts)
            }
        }
    }
}