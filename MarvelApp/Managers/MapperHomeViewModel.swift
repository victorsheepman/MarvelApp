//
//  MapperHomeViewModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 28/2/24.
//

import Foundation

struct MapperHomeViewModel {
    func map(entity:[Character])->[HomeViewModel] {
        return entity.map { HomeViewModel(name: $0.name, backdropPath: getImgUrl(thumbnail: $0.thumbnail)) }
    }
    
    private func getImgUrl(thumbnail:[String: String])->URL?{
        if let path = thumbnail["path"], let ext = thumbnail["extension"] {
            let urlImg = path + "." + ext
            return URL(string: urlImg)
        }
        return nil
    }
}
