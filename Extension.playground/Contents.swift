//: Playground - noun: a place where people can play

import UIKit

extension UILabel {
    
    private struct AssociatedKeys {
        static var key = "anotherText"
    }
    
    public var anotherText: String? {
        set(newValue)  {
            objc_setAssociatedObject(self, &AssociatedKeys.key, newValue as String?, .OBJC_ASSOCIATION_COPY)
        }
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.key) as! String?
        }
    }
    
    public func exchange() {
        (text, anotherText) = (anotherText, text)
    }
}

let label: UILabel = UILabel()
label.text = "text"
label.anotherText = "anotherText"

label.text
label.anotherText

label.exchange()
label.text
label.anotherText


