//
//  SettingCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import Foundation
import UIKit

class SettingCoordinator: CoordinatorProtocol {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        
    }
    
    func start() {
        let settingView = SettingViewController(nibName:  "SettingViewController", bundle: nil)
        
        self.viewController?.navigationController?.navigationBar.isHidden = false
        self.viewController?.navigationController?.navigationBar.tintColor = .red
        self.viewController?.navigationController?.pushViewController(settingView, animated: true)
    }
    
    
}
