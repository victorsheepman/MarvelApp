//
//  DetailCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import Foundation
import UIKit

class DetailCoordinator:CoordinatorProtocol {
   
    
    var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
   
    
    func start() {
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil) 
   
        self.viewController?.navigationController?.show(detailView, sender: nil)
    }
    
}
