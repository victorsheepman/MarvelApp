//
//  SettingViewController.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
     let userDefaultManager = UserDefaultManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Setting"
        darkModeSwitch.isOn = userDefaultManager.getValue()
    }


    @IBAction func showDarkMode(_ sender: UISwitch) {
        userDefaultManager.setValue(newValue: sender.isOn)
        configureDarkMode()
    }
    
    @IBAction func deleteFavorites(_ sender: Any) {
        if !userDefaultManager.getFavorites().isEmpty{
            showAlert(title: "Advertencia", message: "Desea eliminar todos sus heroes favoritos?")
        }else {
            showModal(title: "Error", message: "No tiene heroes favoritos para eliminar")
        }
        
    }
    
    private func showAlert(title: String, message: String) {
        
        let yesHandler: (UIAlertAction) -> Void = { _ in
            self.userDefaultManager.removeFavorites()
            self.showModal(title: "Heroes favoritos eliminados", message: "")
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Sí", style: .default, handler: yesHandler)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func showModal(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureDarkMode(){
        if #available(iOS 13.0, *){
            let appDelegate = UIApplication.shared.windows.first
            let isDarkMode = userDefaultManager.getValue()
            
            if isDarkMode {
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
                
            appDelegate?.overrideUserInterfaceStyle = .light
            return
        }
    }
    
}
