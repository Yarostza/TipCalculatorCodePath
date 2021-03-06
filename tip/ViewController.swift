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
    @IBOutlet weak var tipTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var peopleTipping: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // on load, sets percent slider to previously saved default
        update_percent(0)
        // on load, set color theme based on saved default
        update_theme(0)
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
        if (defaults.integer(forKey: "theme_changed") > 0) {
            update_theme(0)
            defaults.set(0, forKey: "theme_changed")
            defaults.synchronize()
        }
    }
    
    func update_percent(_ sender: Any) {
        // get default slider value, and set slider
        let default_index = defaults.integer(forKey: "defaultindex")
        tipControl.selectedSegmentIndex = default_index
    }
    
    // The following function changes the color theme and saves it. I used:
    // https://www.youtube.com/watch?v=2WWUKsEPc1A as a guide.
    func update_theme(_ sender: Any) {
        switch defaults.integer(forKey: "defaulttheme") {
        case 0:
            overrideUserInterfaceStyle = .unspecified
        case 1:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default:
            overrideUserInterfaceStyle = .unspecified
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get initial bill amount and calculate tip
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15, 0.18, 0.2]
        let tipSplit = [1, 2, 3, 4, 5]
        
        // Calculate tip and total
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let tip_each = tip / Double(tipSplit[peopleTipping.selectedSegmentIndex])
        let tip_each_percision = (tip_each * 100).rounded(.up) / 100
        let tip_total = tip_each_percision * Double(tipSplit[peopleTipping.selectedSegmentIndex])
        let total = bill + tip_total
        
        // Update the tip and total labels
        tipPercentageLabel.text = String(format: "$%.2f", tip_each_percision)
        tipTotalLabel.text = String(format: "$%.2f", tip_total)
        totalLabel.text = String(format: "$%.2f", total)
    }
}
