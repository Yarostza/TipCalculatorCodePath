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
    @IBOutlet weak var ThemeControl: UISegmentedControl!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Below loads in and sets the default tip value from earlier entry
        let default_index = defaults.integer(forKey: "defaultindex")
        TipDefaultControl.selectedSegmentIndex = default_index
        // Below loads in default for color theme
        let default_theme = defaults.integer(forKey: "defaulttheme")
        ThemeControl.selectedSegmentIndex = default_theme
        //update theme color
        ThemeSlider(0)
        // Do any additional setup after loading the view.
    }

    // The following function changes the color theme and saves it. I used:
    // https://www.youtube.com/watch?v=2WWUKsEPc1A as a guide.
    @IBAction func ThemeSlider(_ sender: Any) {
        switch ThemeControl.selectedSegmentIndex {
        case 0:
            overrideUserInterfaceStyle = .unspecified
        case 1:
            overrideUserInterfaceStyle = .light
        case 2:
            overrideUserInterfaceStyle = .dark
        default:
            overrideUserInterfaceStyle = .unspecified
        }
        let theme_index = ThemeControl.selectedSegmentIndex
        defaults.set(theme_index, forKey: "defaulttheme")
        defaults.set(1, forKey: "theme_changed")
        defaults.synchronize()
    }
    
    @IBAction func onTap(_ sender: Any) {
    }
    
    @IBAction func default_selection(_ sender: Any) {
        // grab new selection
        let slide_index = TipDefaultControl.selectedSegmentIndex
        defaults.set(slide_index, forKey: "defaultindex")
        // if the default has been changed, set default changed to 1
        defaults.set(1, forKey: "default_changed")
        defaults.synchronize()
    }

}
