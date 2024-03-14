//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var heroId:Int?
    private let dataManager = ExternalDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.heroDetailDelegate = self
        if let id = heroId {
            dataManager.getCharacterById(id: id)
        }
        
        startActivity()
        nameLabel.text = ""
    }
    
    
    
    private func startActivity(){
        activity.startAnimating()
    }
    
    private func stopActivity(){
        activity.stopAnimating()
        activity.isHidden = true
        configureImageView()
    }
    private func configureImageView(){
        
        //imageView.image = UIImage(named: "bg4")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.insertSublayer(createGradientImage(image: imageView), at: 0)
        imageView.backgroundColor = .clear
    }
    private func createGradientImage(image:UIImageView) -> CAGradientLayer{
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = image.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        return gradientLayer
    }
    
    
    
    
    
}

extension DetailViewController:GetHeroDetailProtocol {
    func getHeroDetail(hero: DetailModel) {
       
        
        
        DispatchQueue.main.async {
            if let img = hero.backdropPath {
                AF.request(img).responseImage { response in
                    if let image = response.value {
                        self.imageView.image = image
                    }
                }
            }
            self.nameLabel.text = hero.name
            self.stopActivity()
        }
    }
}
