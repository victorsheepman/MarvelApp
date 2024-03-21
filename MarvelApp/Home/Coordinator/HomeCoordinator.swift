//
//  CustomCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 6/2/24.
//

import Foundation
import UIKit

class HomeCoordinator: CoordinatorProtocol {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    func start() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: .main)
        let homeView = storyBoard.instantiateViewController(withIdentifier: "tab")
        self.viewController?.navigationController?.pushViewController(homeView, animated: false)
        
    }
    
    
}
