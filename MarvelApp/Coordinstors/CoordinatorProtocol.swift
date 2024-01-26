//
//  CoordinatorProtocol.swift
//  MarvelApp
//
//  Created by Victor Marquez on 26/1/24.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var viewController: UIViewController? { get }
    var navigationController: UINavigationController? { get }
    
    func start()
}

extension CoordinatorProtocol {
    var viewController: UIViewController? { nil }
    var navigationController: UINavigationController? { nil }
}
