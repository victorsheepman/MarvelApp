//
//  ExternalDataManager.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation
import CryptoKit
import UIKit

protocol ExternalDataProtocol {
    func getHeroList(list:[Character])
}

protocol GetHeroDetailProtocol {
    func getHeroDetail(hero: [Result])
}

class ExternalDataManager {
    
    var delegate:ExternalDataProtocol!
    var heroDetailDelegate:GetHeroDetailProtocol!
    
    private let ts = String(Date().timeIntervalSince1970)
    private let session = URLSession(configuration: .default)
    private let decoder = JSONDecoder()
 
    func fetchApi(){
        let hash = getHash(data: "\(ts)\(Constants.Keys.privateKey)\(Constants.Keys.publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(Constants.Keys.publicKey)&hash=\(hash)&limit=100&offset=0"
        
      

        session.dataTask(with: URL(string:url)!) { data, _, err in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else { return }
            
            do{
                let characters = try self.decoder.decode(APIResult.self, from:APIData)
                
                self.delegate.getHeroList(list: characters.data.results)
            }catch {
                print("Hubo un error")
            }
        }.resume()
    }
    
    func getCharacterById(id:Int, viewController: DetailViewController){
        let hash = getHash(data: "\(ts)\(Constants.Keys.privateKey)\(Constants.Keys.publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters/\(id)?ts=\(ts)&apikey=\(Constants.Keys.publicKey)&hash=\(hash)&format=comic&formatType=comic&limit=30"
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            if let error = err {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let result = try self.decoder.decode(CharacterDetail.self, from:data)
                
                self.heroDetailDelegate.getHeroDetail(hero: result.data.results)
            }catch let error{
                print("call error\(error)")
                DispatchQueue.main.async {
                    viewController.showAlert(title: "Error", message: "Hubo un error en la llamada")

                }
            }
        }.resume()
        
        
        
    }
    
    private func getHash(data: String)->String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
