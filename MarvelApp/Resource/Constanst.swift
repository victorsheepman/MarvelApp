//
//  Constanst.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation

struct Constants {
    
    static let APP_NAME = "Nombre de la App"
    
    
    //MARK: -  IDENTIFIERS
    
    struct Identifiers {
        
        static let homeView = "homeView"
        static let loginView = "loginView"
        static let rememberView = "rememberView"
        
    }
    
    //MARK: -  Keys
    
    struct Keys {
        static let publicKey = "486ce811693dd0ffba4d053c3279bac9"
        static let privateKey = "9c82799eeceafe9f814951b577bfc5ea868a550a"
    }
   
    
    //MARK: -  ENVIRONMENT
    
    struct Entornos {
        static let TRAINING = "http://la URL que sea"
        static let PRODUCCION = "http://la URL que sea"
}
    
    struct Setting {
        static let title = "Setting"
        static let titleModal = "Favorite heroes eliminated"
        struct alertWarning {
            static let message =  "Do you want to delete all your favorite heroes?"
            static let title = "Warning"
        }
        struct alertError {
            static let message =  "There are no favorite heroes to eliminate"
            static let title = "Error"
        }
    }

}
