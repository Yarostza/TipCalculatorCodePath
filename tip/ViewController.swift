//
//  ViewController.swift
//  tip
//
//  Created by Zachary Yarost on 8/14/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // on load, sets percent slider to previously saved default
        update_percent(0)
        // the code below opens the keyboard by making the bill amount
        // the first responder. I used the following link to learn this function:
        // https://developer.apple.com/documentation/uikit/uitextfield
        billAmountTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
// The function below updates
// the slider if the default percent was changed.
// https://developer.apple.com/documentation/uikit/
// uiviewcontroller/1621423-viewdidappear
    
    override func viewWillAppear(_ animated: Bool) {
        if (defaults.integer(forKey: "default_changed") > 0) {
            update_percent(0)
            defaults.set(0, forKey: "default_changed")
            defaults.synchronize()
        }
    }
    
    func update_percent(_ sender: Any) {
        // get default slider value, and set slider
        let default_index = defaults.integer(forKey: "defaultindex")
        tipControl.selectedSegmentIndex = default_index
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get initial bill amount and calculate tip
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        
        // Calculate tip and total
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
