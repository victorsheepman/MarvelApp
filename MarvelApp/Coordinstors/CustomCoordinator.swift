//
//  CustomCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 6/2/24.
//

import Foundation
import UIKit

class CustomCoordinator: CoordinatorProtocol {
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    
    func start() {
       print("start")
    }
    
    
}
