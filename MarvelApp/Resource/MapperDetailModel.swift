//
//  MapperDetailModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 14/3/24.
//

import Foundation
struct MapperDetailModel {
    func mapToDetail(entity:[Result])->DetailModel{
        let character = entity[0]
        return DetailModel(name: character.name, backdropPath: getImageUrlFromDetail(thumbnail: character.thumbnail), description: character.description, events: character.events.items, series: character.series.items, stories: character.stories.items, comics: character.comics.items)
    }
    }
    private func getImageUrlFromDetail(thumbnail:Thumbnail)->String?{
        let urlImg = thumbnail.path + "." + thumbnail.thumbnailExtension
        return urlImg
    }

