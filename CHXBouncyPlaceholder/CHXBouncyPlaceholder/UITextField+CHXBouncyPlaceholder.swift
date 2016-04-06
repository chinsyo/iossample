//
//  UITextField+CHXBouncyPlaceholder.swift
//  CHXBouncyPlaceholder
//
//  Created by 王晨晓 on 16/4/5.
//  Copyright © 2016年 winsan. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

var kAlwaysBouncePlaceholderPointer: Void?
var kAbbriviatedPlaceholderPointer: Void?
var kPlaceholderLabelPointer: Void?
var kRightPlaceholderLabelPointer: Void?

let kAnimationDuration: CFTimeInterval = 0.6

extension UITextField {
    
    @IBInspectable public var alwaysBouncePlaceholder: Bool {
        set(newValue) {
            chx_placeholderLabel.hidden = !newValue
            objc_setAssociatedObject(self, &kAlwaysBouncePlaceholderPointer, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            let alwaysBouncePlaceholderObject: AnyObject? = objc_getAssociatedObject(self, &kAlwaysBouncePlaceholderPointer)
            if let alwaysBouncePlaceholder = alwaysBouncePlaceholderObject?.boolValue {
                return alwaysBouncePlaceholder
            }
            return false
        }
    }
    
    @IBInspectable public var abbreviatedPlaceholder: String? {
        set(newValue) {
            chx_rightPlaceHolderLabel.text = newValue
            objc_setAssociatedObject(self, &kAbbriviatedPlaceholderPointer, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            let abbreviatedPlaceholderObject: AnyObject? = objc_getAssociatedObject(self, &kAbbriviatedPlaceholderPointer)
            if let abbreviatedPlaceholder: AnyObject? = abbreviatedPlaceholderObject {
                return abbreviatedPlaceholder as? String
            }
            return .None
        }
    }
    
    private var widthOfAbbreviatedPlaceholder: Float {
        get {
            let rightPlaceholder: String? = !abbreviatedPlaceholder!.isEmpty ? abbreviatedPlaceholder : placeholder
            if let rightPlaceholder = rightPlaceholder {
                let attributes = [NSFontAttributeName: chx_rightPlaceHolderLabel.font]
                let abbreviatedSize = rightPlaceholder.sizeWithAttributes(attributes)
                return Float(abbreviatedSize.width)
            }
            return 0
        }
    }
    
    private var chx_placeholderLabel: UILabel {
        get {
            return UILabel()
        }
    }
    
    private var chx_rightPlaceHolderLabel: UILabel {
        get {
            return UILabel()
        }
    }
    
    func didChange(notification: NSNotification) {
        guard notification.object === self else {
            return
        }
        guard let text = text else {
            return
        }
        if text.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            if alwaysBouncePlaceholder {
                animatePlaceholder(toRight: true)
            } else {
                chx_placeholderLabel.hidden = true
            }
        } else {
            if alwaysBouncePlaceholder {
                animatePlaceholder(toRight: false)
            } else {
                chx_placeholderLabel.hidden = false
            }
        }
    }
    
    private func bounceAnimationKeyframes(toRight toRight: Bool) -> NSArray {
        return []
    }
    
    private func animatePlaceholder(toRight toRight: Bool) {
        
    }
}
