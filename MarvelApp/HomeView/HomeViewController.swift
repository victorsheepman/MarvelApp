//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            guard let image = UIImage(named: "search-filled") else { return }
            textField.tintColor = UIColor.lightGray
            textField.setIcon(image)
         }
    }
    private var characters = [Character]()
    let dataManager = ExternalDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("esdtoy eaqyu")
        dataManager.delegate = self
        dataManager.fetchApi()
      
    }
    
}


extension HomeViewController:ExternalDataProtocol {
    func getHeroList(list: [Character]) {
        characters = list
        print(characters)
    }
    
    
}

extension UITextField {
    func setIcon(_ image: UIImage) {
       let iconView = UIImageView(frame:
                      CGRect(x: 10, y: 5, width: 20, height: 20))
       iconView.image = image
       let iconContainerView: UIView = UIView(frame:
                      CGRect(x: 20, y: 0, width: 30, height: 30))
       iconContainerView.addSubview(iconView)
       leftView = iconContainerView
       leftViewMode = .always
    }
}
