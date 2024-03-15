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
    
    private func getImageUrlFromDetail(thumbnail:Thumbnail)->String?{
        let urlImg = thumbnail.path + "." + thumbnail.thumbnailExtension
        return urlImg
    }

    func mapToTableViewData(hero:DetailModel)->[CellData]{
        let categoryCell = createCategoryCell(hero: hero)
        var dataCell = [CellData]()
        for (category, list) in categoryCell {
            let cellData = CellData(opened: false, title: category, sectionData: list)
            dataCell.append(cellData)
        }
        return dataCell
    }
    
    private func createCategoryCell(hero: DetailModel) -> [String: [String]] {
        var categoryData: [String: [String]] = [:]

        if !hero.comics.isEmpty {
            let comicsNames = hero.comics.map { $0.name }
            categoryData["Comics"] = comicsNames
        }else{
            categoryData["Comics"] = ["No Comics"]
         }

        if !hero.series.isEmpty {
            let seriesNames = hero.series.map { $0.name }
            categoryData["Series"] = seriesNames
        }else{
            categoryData["Series"] = ["No Series"]
         }

        if !hero.events.isEmpty {
            
            var eventsNames = hero.events.map { $0.name }
            
            if eventsNames.count == 1{
                eventsNames.append(hero.events[0].name)
            }
            
            categoryData["Events"] = eventsNames
        }else{
            categoryData["Events"] = ["","No Events"]
         }

        if !hero.stories.isEmpty {
            let storiesNames = hero.stories.map { $0.name }
            categoryData["Stories"] = storiesNames
        }else{
            categoryData["Stories"] = ["No Stories"]
         }

        return categoryData
    }

}
   
