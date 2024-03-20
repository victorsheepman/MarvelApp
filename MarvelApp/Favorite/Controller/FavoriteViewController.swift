//
//  FavoriteViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import UIKit

class FavoriteViewController: UIViewController {


    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var favoriteCollectionView: UICollectionView!
    
    private var settingCoordinator: SettingCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    

    
    @IBAction func goToSetting(_ sender: Any) {
        settingCoordinator = SettingCoordinator(viewController: self)
        settingCoordinator?.start()
    }
    
}
