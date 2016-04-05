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

extension UITextField {
    @IBInspectable public var alwaysBouncePlaceholder: Bool {
        set(newValue) {
            
        }
        get{
            return false
        }
    }
    
    @IBInspectable public var abbreviatedPlaceholder: String? {
        set(newValue) {

        }
        get {
            return ""
        }
    }
    
    private var widthOfAbbreviatedPlaceholder: Float {
        get {
            return 1.0
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
    
    // override public func drawPlaceholderInRect(Rect: CGRect) {}
    
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
