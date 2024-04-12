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
    var ids = [Int]()
    
    private var favorites: [HomeModel] {
        return characters.filter { character in
            return ids.contains(character.id)
        }
    }
    
    private var settingCoordinator: SettingCoordinator?
    private let userDefaultManager = UserDefaultManager()
    private let dataManager = ApiManager()
    private let mapper = MapperHomeModel()
    private var detailCoordinator: DetailCoordinator?
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.delegate = self
        dataManager.fetchApi()
        favoriteCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        startActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        ids = userDefaultManager.getFavorites()
        favoriteCollectionView.reloadData()
    }
    
    private func startActivity(){
        activityView.startAnimating()
    }
    
    private func stopActivity(){
        activityView.stopAnimating()
        activityView.isHidden = true
    }
    

    
    @IBAction func goToSetting(_ sender: Any) {
        settingCoordinator = SettingCoordinator(viewController: self)
        settingCoordinator?.start()
    }
    
}


extension FavoriteViewController:ApiDataSource  {
    func getHeroList(list: [CharacterModel]) {
        characters = mapper.map(entity: list)
        
        DispatchQueue.main.async {
            self.favoriteCollectionView.reloadData()
            self.stopActivity()
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
        detailCoordinator = DetailCoordinator(viewController: self)
        detailCoordinator?.start(id: self.favorites[indexPath.row].id)
    }
}


extension FavoriteViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (collectionView.frame.size.width - 10)/2
        
        return CGSize(width: size, height: 230)
    }
}
