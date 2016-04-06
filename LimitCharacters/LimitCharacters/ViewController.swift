//
//  ViewController.swift
//  LimitCharacters
//
//  Created by 王晨晓 on 16/4/6.
//  Copyright © 2016年 winsan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tweetTextView.delegate = self
        tweetTextView.backgroundColor = UIColor.clearColor()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow", name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let myTextViewString = tweetTextView.text
        wordCountLabel.text = "\(140 - myTextViewString.characters.count)"
        if range.length > 140 {
            return false
        }
        
        let newLength = (myTextViewString?.characters.count)! + range.length
        return newLength < 140
    }
    
//    func keyboardWillShow(notification: NSNotification) {
//    
//    }
//    
//    func keyboardWillHide(notification: NSNotification) {
//    
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

