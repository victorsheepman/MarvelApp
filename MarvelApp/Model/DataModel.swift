//
//  DataModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 12/4/24.
//

import Foundation

struct DataModel: Codable {
    var count: Int
    var results: [CharacterModel]
}
