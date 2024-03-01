//
//  Character.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation

struct APIResult:Codable {
    var data: APICharacterData
}

struct APICharacterData:Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id:Int
    var name:String
    var description:String
    var thumbnail:[String: String]
    var urls:[[String:String]]
}
