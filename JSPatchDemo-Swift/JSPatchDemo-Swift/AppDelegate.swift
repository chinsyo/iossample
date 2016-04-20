//
//  AppDelegate.swift
//  JSPatchDemo-Swift
//
//  Created by 王晨晓 on 16/4/20.
//  Copyright © 2016年 winsan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let aClass : AnyClass? = NSClassFromString("JSPatchDemo_Swift.ViewController")
        if (nil != aClass) {
            let clsName = NSStringFromClass(aClass!)
            print(clsName)
        } else {
            print("error ViewController not found")
        }
        
        let bClass : AnyClass? = NSClassFromString("JSPatchDemo_Swift.TestObject")
        if (nil != bClass) {
            let clsName = NSStringFromClass(bClass!)
            print(clsName)
        } else {
            print("error TestObject not found")
        }
        
        let path = NSBundle.mainBundle().pathForResource("demo", ofType: "js")
        do {
            let patch = try String(contentsOfFile: path!)
            JPEngine.startEngine()
            JPEngine.evaluateScript(patch)
        } catch {}
        return true
    }
}

