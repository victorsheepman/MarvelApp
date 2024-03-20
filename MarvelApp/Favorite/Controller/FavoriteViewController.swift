//
//  FavoriteViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoriteViewController: UIViewController {
    

    var characters = [HomeModel]()
    
    private var favorites: [HomeModel] {
        let list = userDefaultManager.getFavorites()
        return characters.filter { character in
            return list.contains(character.id)
        }
    }
    
    private var settingCoordinator: SettingCoordinator?
    private let userDefaultManager = UserDefaultManager()
    private let dataManager = ExternalDataManager()
    private let mapper = MapperHomeModel()
    
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchApi()
        favoriteCollectionView.collectionViewLayout = UICollectionViewFlowLayout()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        print(userDefaultManager.getFavorites())
        
    }
    

    
    @IBAction func goToSetting(_ sender: Any) {
        settingCoordinator = SettingCoordinator(viewController: self)
        settingCoordinator?.start()
    }
    
}


extension FavoriteViewController:ExternalDataProtocol {
    func getHeroList(list: [CharacterDTO]) {
        characters = mapper.map(entity: list)
        
        DispatchQueue.main.async {
            self.favoriteCollectionView.reloadData()
                //  self.stopActivity()
        }
    }
}


extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteItem", for: indexPath) as! FavoriteCollectionViewCell
        
        item.labelView.text = favorites[indexPath.row].name
        
        if let img = favorites[indexPath.row].backdropPath {
            AF.request(img).responseImage { response in
                if let image = response.value {
                    item.setBackgroundImage(image: image)
                }
            }
        }
        
        
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //detailCoordinator = DetailCoordinator(viewController: self)
        //detailCoordinator?.start(id: self.filteredCharacter[indexPath.row].id)
    }
}


extension FavoriteViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - 10)/2
        
        return CGSize(width: size, height: 230)
    }
}
