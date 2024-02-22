//
//  MainViewCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation
import UIKit
class MainViewCoordinator:CoordinatorProtocol {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
    func start() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "mainView") as! MainViewController
        
        self.viewController?.navigationController?.pushViewController(mainViewController, animated: false)
        
    }
    
    
}
