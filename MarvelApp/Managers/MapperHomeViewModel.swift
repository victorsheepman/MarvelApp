//
//  MapperHomeViewModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 28/2/24.
//

import Foundation

struct MapperHomeViewModel {
    func map(entity:[Character])->Void {
        print(getImgUrl(thumbnail: entity[0].thumbnail))
    }
    
    private func getImgUrl(thumbnail:[String: String])->String?{
        if let path = thumbnail["path"] {
            return path
        }
        return nil
    }
}
