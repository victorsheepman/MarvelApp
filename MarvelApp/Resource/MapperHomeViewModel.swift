//
//  MapperHomeViewModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 28/2/24.
//

import Foundation

struct MapperHomeModel {
    func map(entity:[CharacterModel])->[HomeModel] {
        return entity.map { HomeModel(name: $0.name, backdropPath: getImgUrl(thumbnail: $0.thumbnail), id: $0.id) }
    }
    
    private func getImgUrl(thumbnail:[String: String])->String?{
        if let path = thumbnail["path"], let ext = thumbnail["extension"] {
            let urlImg = path + "." + ext
            return urlImg
        }
        return nil
    }
}
