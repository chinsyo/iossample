//
//  ViewController.swift
//  Swift01_StopWatch
//
//  Created by 王晨晓 on 16/3/17.
//  Copyright © 2016年 winsan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer = NSTimer()
    var count = 0.0
    var isPlaying = false
    
    let timeInterval: NSTimeInterval = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.text = String(format: "%.1f", count)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    deinit {
        if (timer.valid) {
            timer.invalidate()
        }
    }
    
    func timerAction() {
        count += 0.1
        timeLabel.text = String(format: "%.1f", count)
    }
    
    @IBAction func onPauseButton(sender: UIButton) {
        if (!isPlaying) {
            return
        }
        playButton.enabled = true
        pauseButton.enabled = false
        timer.invalidate()
        isPlaying = false
    }
    
    @IBAction func onPlayButton(sender: UIButton) {
        if (isPlaying) {
            return
        }
        playButton.enabled = false
        pauseButton.enabled = true
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: Selector("timerAction"), userInfo: nil, repeats: true)
        let runloop = NSRunLoop.currentRunLoop()
        runloop.addTimer(timer, forMode: NSRunLoopCommonModes)
        isPlaying = true
    }
    
    @IBAction func onResetButton(sender: UIButton) {
        timer.invalidate()
        isPlaying = false
        count = 0
        timeLabel.text = String(format: "%.1f", count)
        playButton.enabled = true
        pauseButton.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

