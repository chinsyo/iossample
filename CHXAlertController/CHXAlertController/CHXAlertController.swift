//
//  CHXAlertController.swift
//  CHXAlertController
//
//  Created by 王晨晓 on 16/4/22.
//  Copyright © 2016年 winsan. All rights reserved.
//

import UIKit

public enum CHXAlertControllerStyle: Int {
    case ActionSheet, AlertController
}

public enum CHXButtonActionType: Int {
    case Selector, Closure
}

@objc public protocol CHXAlertControllerDelegate {
    optional func alertControllerWillAppear(alertController: CHXAlertController)
    optional func alertControllerDidAppear(alertController: CHXAlertController)
    optional func alertControllerWillDisappear(alertController: CHXAlertController)
    optional func alertControllerDidDisappear(alertController: CHXAlertController)
    optional func alertController(alertController: CHXAlertController, didSelectItemAtIndex index: Int)
}

@objc public protocol CHXAlertControllerDataSource {
    optional func numberOfItemsInAlertController(alertController: CHXAlertController) -> Int
    optional func alertController(alertController: CHXAlertController, titleForItemAtIndex index: Int) -> String
    optional func alertController(alertController: CHXAlertController, imageForItemAtIndex index: Int) -> UIImage?
}

public class CHXAlertController: UIViewController {
    
    private var topViewController: UIViewController {
        var topViewController = UIApplication.sharedApplication().keyWindow?.rootViewController
        if (nil != topViewController?.presentedViewController) {
            topViewController = topViewController?.presentedViewController
        }
        return topViewController!
    }
    
    /**
    deinit {
    
    }
    
    public init() {
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience public init(title: String?, message: String?, style:CHXAlertControllerStyle) {
        
    }
    */
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func show() {
    
    }
    
    public func dismiss() {
    
    }
    
    private func startActionButtonAppearAnimation() {
    
    }
    
    private func startCloseButtonAppearAnimation() {
    
    }
    
    private func onClick(index: Int) {
    
    }
}

extension CHXAlertController: CHXAlertControllerDataSource {
    func numberOfItemsInAlertController(alertController: CHXAlertController) -> Int {
        return 10
    }
    
    func alertController(alertController: CHXAlertController, titleForItemAtIndex index: Int) -> String {
        return "title \(index)"
    }
    
    func alertController(alertController: CHXAlertController, imageForItemAtIndex index: Int) -> UIImage? {
        return nil
    }
}

extension CHXAlertController: CHXAlertControllerDelegate {
    public func alertControllerWillAppear(alertController: CHXAlertController) {
        print("\(alertController.self) will appear")
    }
    
    public func alertControllerDidAppear(alertController: CHXAlertController) {
        print("\(alertController.self) did appear")
    }
    
    public func alertControllerWillDisappear(alertController: CHXAlertController) {
        print("\(alertController.self) will disappear")
    }
    
    public func alertControllerDidDisappear(alertController: CHXAlertController) {
        print("\(alertController.self) did disappear")
    }
    
    public func alertController(alertController: CHXAlertController, didSelectItemAtIndex index: Int) {
        print("\(alertController.self) did select item at index")
    }
}

extension CHXAlertController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return false
    }
}

private class CHXActionButton: UIButton {

}

private class CHXAccessoryView: UIView {
    override func drawRect(rect: CGRect) {
        let color = UIColor.blackColor()
        color.setFill()
        let point = UIBezierPath(arcCenter: self.center, radius: 3, startAngle: 0, endAngle: 360, clockwise: true)
        point.fill()
    }
}