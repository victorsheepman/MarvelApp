//
//  MainCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorProtocol {
  
    
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainView = storyboard.instantiateViewController(withIdentifier: "MainView")
        
        navigationController?.pushViewController(mainView, animated:true)
        
    }
}
