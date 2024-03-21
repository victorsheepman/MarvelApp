//
//  Character.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation

struct ResultDTO:Codable {
    var data: CharacterDataDTO
}

struct CharacterDataDTO: Codable {
    var count: Int
    var results: [CharacterDTO]
}

struct CharacterDTO: Identifiable, Codable {
    var id:Int
    var name:String
    var description:String
    var thumbnail:[String: String]
    var urls:[[String:String]]
}