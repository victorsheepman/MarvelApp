//
//  Character.swift
//  MarvelApp
//
//  Created by Victor Marquez on 22/2/24.
//

import Foundation



struct CharacterModel: Identifiable, Codable {
    var id:Int
    var name:String
    var description:String
    var thumbnail:[String: String]
    var urls:[[String:String]]
}
