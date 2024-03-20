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
        if defaults.bool(forKey: "kSavedValue") == false{
            let defaultValues:[String:Any] = (["kIsDarkMode":false, "kSavedValue":true, "kFavoriteList":[Int]()])
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
    
    func setFavorite(newFavorite:Int){
        var list: [Int] = UserDefaults.standard.value(forKey:"kFavoriteList") as! [Int]
        if !list.contains(newFavorite){
            list.append(newFavorite)
            UserDefaults.standard.set(list, forKey: "kFavoriteList")
        }
    }
    
    func getFavorites()->[Int]{
        let list: [Int] = UserDefaults.standard.value(forKey:"kFavoriteList") as! [Int]
        return list
    }
}
