//
//  ExternalDataManager.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation
import CryptoKit

protocol ExternalDataProtocol {
    func getHeroList(list:[HomeViewModel])
}

class ExternalDataManager {
    var delegate:ExternalDataProtocol!
    private let mapper = MapperHomeViewModel()
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
                let result =  self.mapper.map(entity: characters.data.results)
                self.delegate.getHeroList(list: result)
            }catch {
                print("Hubo un error")
            }
        }.resume()
    }
    
    func getComicsById(id:Int){
        let hash = getHash(data: "\(ts)\(Constants.Keys.privateKey)\(Constants.Keys.publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters/\(id)/comics?ts=\(ts)&apikey=\(Constants.Keys.publicKey)&hash=\(hash)&limit=100&offset=0"
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            if let error = err {
                fatalError(error.localizedDescription)
               // return
            }
            
            guard let data = data else {return}
            
            do{
                let comics = try self.decoder.decode(ComicsResponse.self, from: data)
                print("resulst: \(comics)")
            }catch {
                fatalError("Hubo error")
            }
        }
        
        
        
    }
    
    private func getHash(data: String)->String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
    
}
