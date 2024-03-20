//
//  DetailCoordinator.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import Foundation
import UIKit
protocol DeteilCoordinatorProtocol {
    var viewController: UIViewController? { get }
    func start(id: Int)
}

class DetailCoordinator:DeteilCoordinatorProtocol {
   
    var viewController: UIViewController?
    
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
   
    func start(id:Int) {
        
        let detailView = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailView.heroId = id
        self.viewController?.navigationController?.navigationBar.isHidden = false
        self.viewController?.navigationController?.navigationBar.tintColor = .red
        self.viewController?.navigationController?.pushViewController(detailView, animated: true)
        
    }
}
