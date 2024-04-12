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
    
    @IBOutlet weak private var tabBar: UITabBar!
    @IBOutlet weak private var textField: UITextField! {
        didSet {
            guard let image = UIImage(named: "search-filled") else { return }
            textField.tintColor = UIColor.lightGray
            textField.setIcon(image)
        }
    }
    
    @IBOutlet weak private var homeCollectionView: UICollectionView!
    @IBOutlet weak private var activity: UIActivityIndicatorView!
    
    private let mapper = MapperHomeModel()
    private var characters = [HomeModel]()
    private var filteredCharacter = [HomeModel]()
    private let dataManager = ApiManager()
    private var detailCoordinator: DetailCoordinator?
    private var settingCoordinator: SettingCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchApi()
        homeCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        startActivity()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
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
    
   
    @IBAction func goToSetting(_ sender: Any) {
        settingCoordinator = SettingCoordinator(viewController: self)
        settingCoordinator?.start()
    }
    

}


extension HomeViewController:ApiDataSource {
    func getHeroList(list: [CharacterDTO]) {
        characters = mapper.map(entity: list)
        
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
        detailCoordinator?.start(id: self.filteredCharacter[indexPath.row].id)
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
                return character.name.lowercased().contains(value.lowercased())
            })
            
        }
    }
}
