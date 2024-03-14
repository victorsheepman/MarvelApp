//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import UIKit
import Alamofire
import AlamofireImage


struct CellData{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var heroId:Int?
    private let dataManager = ExternalDataManager()
    private var data = [[String]]()
    var tableViewData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataManager.heroDetailDelegate = self
        if let id = heroId {
            dataManager.getCharacterById(id: id, viewController: self)
        }

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        configureLabel()
        startActivity()
       
    }
    
    private func configureLabel(){
        nameLabel.text = ""
        nameLabel.frame.size = CGSize(width: 200, height: 100)
        
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.numberOfLines = 0
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
       
        var categoryData: [String: [String]] = [:]

        if !hero.comics.isEmpty {
            let comicsNames = hero.comics.map { $0.name }
            categoryData["Comics"] = comicsNames
        }

        if !hero.series.isEmpty {
            let seriesNames = hero.series.map { $0.name }
            categoryData["Series"] = seriesNames
        }

        if !hero.events.isEmpty {
            let eventsNames = hero.events.map { $0.name }
            categoryData["Events"] = eventsNames
        }

        if !hero.stories.isEmpty {
            let storiesNames = hero.stories.map { $0.name }
            categoryData["Stories"] = storiesNames
        }

        DispatchQueue.main.async {
            if let img = hero.backdropPath {
                AF.request(img).responseImage { response in
                    if let image = response.value {
                        self.imageView.image = image
                    }
                }
            }
            //self.data = [comics, series, events, stories]
            for (category, data) in categoryData {
                let cellData = CellData(opened: false, title: category, sectionData: data)
                self.tableViewData.append(cellData)
            }
            self.nameLabel.text = hero.name
            if !hero.description.isEmpty {
                self.descriptionLabel.text = hero.description
            }else{
                self.descriptionLabel.text = "No description" 
            }
           
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
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].sectionData.count
        }else {
            return 1
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var listContent = UIListContentConfiguration.cell()
        if indexPath.row == 0 {
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
            
            listContent.text = tableViewData[indexPath.section].title
            listContent.textProperties.color = .gray
            listContent.textProperties.font =  UIFont.boldSystemFont(ofSize: 17)
            cell.contentConfiguration = listContent
            
            return cell
        }else{
            guard let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell") else {return UITableViewCell()}
           
            listContent.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            cell.contentConfiguration = listContent
            
            return cell
        }
        
        
        
        
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = data[indexPath.section][indexPath.row]
        
        var listContent = UIListContentConfiguration.cell()
        listContent.text = model
        cell.contentConfiguration = listContent
        return cell*/
    }
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Comics"
        case 1:
            return "Series"
        case 2:
            return "Events"
        case 3:
            return "Stories"
        default:
            return "null"
        }
    }*/
}

extension DetailViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].opened == true {
            tableViewData[indexPath.section].opened = false
            
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            
            tableViewData[indexPath.section].opened = true
            
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}
