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
    
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    var heroId:Int?
    private let dataManager = ExternalDataManager()
    private var settingCoordinator: SettingCoordinator?
    private let mapper = MapperDetailModel()
    private let userDefaultManager = UserDefaultManager()
    private var tableViewData = [CellModel]()
    
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        let myButton = UIBarButtonItem(title: "Options", style: .plain, target: self, action: #selector(goToSetting))
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationItem.rightBarButtonItem = myButton
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
    
   
    
    private func decodeImage(backdropPath:String?){
        if let img = backdropPath {
            AF.request(img).responseImage { response in
                if let image = response.value {
                    self.imageView.image = image
                }
            }
        }
    }
    
    @objc func goToSetting() {
        settingCoordinator = SettingCoordinator(viewController: self)
        settingCoordinator?.start()
    }

    @IBAction func clickLike(_ sender: Any) {
        if btnLike.tag == 0 {
            btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
            
            btnLike.tag = 1
        }else{
            btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if let id =  heroId{
                userDefaultManager.setFavorite(newFavorite: id)
            }
            
            btnLike.tag = 0
            
        }
    }
    


}

extension DetailViewController:GetHeroDetailProtocol {
    func getHeroDetail(hero: [Result]) {
        let heroDetail = mapper.mapToDetail(entity: hero)
        DispatchQueue.main.async {
            
            self.decodeImage(backdropPath: heroDetail.backdropPath)
            self.tableViewData = self.mapper.mapToTableViewData(hero: heroDetail)
            self.nameLabel.text = heroDetail.name
            
            if !heroDetail.description.isEmpty  {
                self.descriptionLabel.text = heroDetail.description
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
            print("indexpath row:\(indexPath.row)")
            listContent.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            cell.contentConfiguration = listContent
            
            return cell
        }
    }
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
