//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // TODO: usar esta variable para asigar el id del heroe y usarlo en el metodo nuevo de ExternalDataManager
    var heroId:Int?
    private let dataManager = ExternalDataManager()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = heroId {
          
            dataManager.getCharacterById(id: id)
        }

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
