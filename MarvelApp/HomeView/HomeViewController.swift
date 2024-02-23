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
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchApi()
        homeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
    }
    
}


extension HomeViewController:ExternalDataProtocol {
    func getHeroList(list: [Character]) {
        characters = list
        
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
    
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! HomeCollectionViewCell

        item.labelView.text = characters[indexPath.row].name
        
        return item
    }
}


extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - 10)/2
        
        return CGSize(width: size, height: 230)
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
