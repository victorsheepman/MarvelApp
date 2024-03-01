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
    
    
    private var characters = [HomeViewModel]()
    private var filteredCharacter = [HomeViewModel]()
    let dataManager = ExternalDataManager()
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filteredCharacter.isEmpty  {
            return filteredCharacter.count
        }
        return characters.count
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
            filteredCharacter = characters.filter{ $0.name.contains(value) }
            DispatchQueue.main.async { [weak self] in
                // Recarga la colección con los resultados del filtro en el hilo principal
                self?.homeCollectionView.reloadData()
                self?.stopActivity()
            }
        }
    }
}
