//
//  DetailViewController.swift
//  HitList
//
//  Created by shawn on 2017/3/24.
//  Copyright © 2017年 chinsyo. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        var allConstraints = [NSLayoutConstraint]()
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .red
        view.addSubview(nameLabel)
        
        let nameTextField = UITextField()
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.backgroundColor = .red
        nameTextField.placeholder = "Input your name here."
        view.addSubview(nameTextField)
        
        let confirmButton = UIButton(type: .system)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        confirmButton.backgroundColor = .red
        view.addSubview(confirmButton)
        
        let views = [
            "label": nameLabel,
            "input": nameTextField,
            "button": confirmButton
        ]
        
        let labelHorizonConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[label]-|",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        allConstraints += labelHorizonConstraints
        
        let textFieldHorizonConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[input]-|",
                                                                        options: [],
                                                                        metrics: nil,
                                                                        views: views)
        allConstraints += textFieldHorizonConstraints
        
        let buttonHorizonConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-[button]-|",
                                                                      options: [],
                                                                      metrics: nil,
                                                                      views: views)
        allConstraints += buttonHorizonConstraints
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[label(30)]-[input(30)]-[button(30)]",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: views)
        allConstraints += verticalConstraints
        NSLayoutConstraint.activate(allConstraints)
        
        // Do any additional setup after loading the view.
    }
    
    func updatePerson(sender: UIBarButtonItem) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
