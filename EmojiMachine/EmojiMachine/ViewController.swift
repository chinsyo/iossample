//
//  ViewController.swift
//  EmojiMachine
//
//  Created by 王晨晓 on 16/3/23.
//  Copyright © 2016年 winsan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var imageArray = [String]()
    var dataArray1 = [Int]()
    var dataArray2 = [Int]()
    var dataArray3 = [Int]()
    var blur : UIVisualEffectView = UIVisualEffectView()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var emojiPickerView: UIPickerView!
    @IBOutlet weak var startButton: UIButton!

    @IBAction func startButtonClick(sender: UIButton) {
        
        emojiPickerView.selectRow(Int(arc4random()%50+50), inComponent: 0, animated: true)
        emojiPickerView.selectRow(Int(arc4random()%50+50), inComponent: 1, animated: true)
        emojiPickerView.selectRow(Int(arc4random()%50+50), inComponent: 2, animated: true)

        let index = dataArray1[emojiPickerView.selectedRowInComponent(0)]
        let food = imageArray[index]
        if (dataArray1[emojiPickerView.selectedRowInComponent(0)] == dataArray2[emojiPickerView.selectedRowInComponent(1)] && dataArray2[emojiPickerView.selectedRowInComponent(1)] == dataArray3[emojiPickerView.selectedRowInComponent(2)]) {
            
            
            resultLabel.text = "刘夏今天吃\(food)💯"
            
        } else if (dataArray1[emojiPickerView.selectedRowInComponent(0)] == dataArray2[emojiPickerView.selectedRowInComponent(1)] || dataArray2[emojiPickerView.selectedRowInComponent(1)] == dataArray3[emojiPickerView.selectedRowInComponent(2)] ||
            dataArray2[emojiPickerView.selectedRowInComponent(0)] ==
            dataArray3[emojiPickerView.selectedRowInComponent(2)]) {
                
            resultLabel.text = "刘夏今天吃\(food)✔️"
                
        } else {
            
            resultLabel.text = "刘夏今天吃\(food)✖️"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageArray = ["🍻", "🍔", "🍉", "🐛", "🍙", "🐷", "💩", "💨", "🍆", "💥"]
        
        for _ in 1...100 {
            dataArray1.append((Int)(arc4random()%10))
            dataArray2.append((Int)(arc4random()%10))
            dataArray3.append((Int)(arc4random()%10))
        }
        
        resultLabel.text = "刘夏今天吃什么?"
        resultLabel.textColor = UIColor.orangeColor()
        resultLabel.font = UIFont(name: "Helvetica", size: 30.0)
        resultLabel.layer.cornerRadius = CGRectGetHeight(resultLabel.frame)/2.4
        resultLabel.layer.borderWidth = 2.0
        resultLabel.layer.borderColor = UIColor.orangeColor().CGColor
        resultLabel.clipsToBounds = true
        
        startButton.tintColor = UIColor.whiteColor()
        startButton.backgroundColor = UIColor.orangeColor()
        startButton.layer.cornerRadius = CGRectGetHeight(startButton.frame)/3.0

        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        emojiPickerView.userInteractionEnabled = false
        
        let effect = UIBlurEffect(style:.Light)
        blur = UIVisualEffectView(effect: effect)
        blur.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 160, self.view.bounds.size.width, 160)
        //blur.alpha = 0.6
        backgroundImage.addSubview(blur)
        //self.view.addSubview(blur)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let label = UILabel()
        
        switch component {
        case 0: label.text = imageArray[dataArray1[row]]
        case 1: label.text = imageArray[dataArray2[row]]
        case 2: label.text = imageArray[dataArray3[row]]
        default: label.text = ""
        }
        
        label.font = UIFont(name: "Apple Color Emoji", size: 80)
        label.textAlignment = .Center
        return label
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
}

