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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var heroId:Int?
    private let dataManager = ExternalDataManager()
    
    private var comics = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.heroDetailDelegate = self
        if let id = heroId {
            dataManager.getCharacterById(id: id, viewController: self)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
       
        let comics  = hero.comics.map {  return $0.name }
        let series  = hero.series.map {  return $0.name }
        let events  = hero.events.map {  return $0.name }
        let stories = hero.stories.map{  return $0.name }
        
        DispatchQueue.main.async {
            if let img = hero.backdropPath {
                AF.request(img).responseImage { response in
                    if let image = response.value {
                        self.imageView.image = image
                    }
                }
            }
            self.comics = [comics, series, events, stories]
            self.nameLabel.text = hero.name
            self.stopActivity()
            self.tableView.reloadData()
        }
    }
}
extension DetailViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let handler: (UIAlertAction) -> Void = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        
        
        present(alertController, animated: true, completion: nil)
    }
}


extension DetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comics[section].count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = comics[indexPath.section][indexPath.row]
        
        var listContent = UIListContentConfiguration.cell()
        listContent.text = model
        cell.contentConfiguration = listContent
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comics"
    }
    
}
