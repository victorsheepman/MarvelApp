//
//  UserDefaultManager.swift
//  MarvelApp
//
//  Created by Victor Marquez on 20/3/24.
//

import Foundation
class UserDefaultManager: NSObject {
    class func initValues(){
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "KSavedValue") == false{
            let defaultValues:[String:Bool] = (["kIsDarkMode":false, "KSavedValue":true])
            defaults.register(defaults: defaultValues)
        }
    }
    
    func setValue(newValue:Bool, key:String? = "kIsDarkMode"){
        if let recivedKey = key{
            UserDefaults.standard.set(newValue, forKey: recivedKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getValue()->Bool {
        let value = UserDefaults.standard.value(forKey:"kIsDarkMode")as! Bool
        return value
    }
}
