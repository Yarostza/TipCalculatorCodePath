//
//  SettingsViewController.swift
//  tip
//
//  Created by Zachary Yarost on 8/19/20.
//  Copyright © 2020 Codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var TipDefaultControl: UISegmentedControl!
     let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Below loads in and sets the default tip value from earlier entry
        let default_index = defaults.integer(forKey: "defaultindex")
        TipDefaultControl.selectedSegmentIndex = default_index
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func default_selection(_ sender: Any) {
        
        // grab new slection
        let slide_index = TipDefaultControl.selectedSegmentIndex
        defaults.set(slide_index, forKey: "defaultindex")
        
        // the code snipit below was origionally used to let me know if the
        // default had been changed. I removed this behavior.
        
        //defaults.set(1, forKey: "default_changed")
        
        defaults.synchronize()
    }

}
