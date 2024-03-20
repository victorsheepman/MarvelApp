//
//  SettingViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
     let userDefaultManager = UserDefaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Setting"
        darkModeSwitch.isOn = userDefaultManager.getValue()
    }


    @IBAction func showDarkMode(_ sender: UISwitch) {
        userDefaultManager.setValue(newValue: sender.isOn)
    }
    
    
}
