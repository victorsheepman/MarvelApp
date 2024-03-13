//
//  HomeViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import UIKit
import Alamofire
import AlamofireImage
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            guard let image = UIImage(named: "search-filled") else { return }
            textField.tintColor = UIColor.lightGray
            textField.setIcon(image)
        }
    }
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var characters = [HomeViewModel]()
    private var filteredCharacter = [HomeViewModel]()
    let dataManager = ExternalDataManager()
    private var detailCoordinator: DetailCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchApi()
        homeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        startActivity()
    }
    
    private func startActivity(){
        activity.startAnimating()
    }
    
    private func stopActivity(){
        activity.stopAnimating()
        activity.isHidden = true
    }
    
    
    private func reloadTableView(){
        DispatchQueue.main.async {
            self.activity.stopAnimating()
            self.activity.isHidden = true
            self.homeCollectionView.reloadData()
        }
    }
    
   
    

}


extension HomeViewController:ExternalDataProtocol {
    func getHeroList(list: [HomeViewModel]) {
        characters = list
        
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
            self.stopActivity()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let searchText = textField.text, !searchText.isEmpty {
            return filteredCharacter.count
        } else {
            return characters.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if filteredCharacter.isEmpty{
            filteredCharacter = characters
        }
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as! HomeCollectionViewCell
        
        item.labelView.text = filteredCharacter[indexPath.row].name
        
        if let img = filteredCharacter[indexPath.row].backdropPath {
            AF.request(img).responseImage { response in
                if let image = response.value {
                    item.setBackgroundImage(image: image)
                }
            }
        }
        
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detailCoordinator = DetailCoordinator(viewController: self)
        detailCoordinator?.start()
    }
}


extension HomeViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - 10)/2
        
        return CGSize(width: size, height: 230)
    }
}


extension HomeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let value = textField.text {
            self.filteredCharacter =  self.characters.filter({ character in
                self.reloadTableView()
                return character.name.contains(value)
            })
            
        }
    }
}
