//
//  ExternalDataManager.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation
import CryptoKit

protocol ExternalDataProtocol {
    func getHeroList(list:[Character])
}

class ExternalDataManager {
    var delegate:ExternalDataProtocol!
    private let mapper = MapperHomeViewModel()
    
    func fetchApi(){
        let ts = String(Date().timeIntervalSince1970)
        let hash = getHash(data: "\(ts)\(Constants.Keys.privateKey)\(Constants.Keys.publicKey)")
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(Constants.Keys.publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string:url)!) { data, _, err in
            if let error = err{
                print(error.localizedDescription)
                return
            }
            
            guard let APIData = data else { return }
            
            do{
                let characters = try JSONDecoder().decode(APIResult.self, from:APIData)
                self.mapper.map(entity: characters.data.results)
                self.delegate.getHeroList(list: characters.data.results)
            }catch {
                print("Hubo un error")
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
