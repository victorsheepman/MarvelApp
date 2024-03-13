//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    var heroId:Int?
    private let dataManager = ExternalDataManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.heroDetailDelegate = self
        if let id = heroId {
            dataManager.getCharacterById(id: id)
        }
    }
}

extension DetailViewController:GetHeroDetailProtocol {
    func getHeroDetail(hero: [Result]) {
        print(hero)
    }
}
