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
            let isOpen = list.isEmpty || list[0].isEmpty
            let cellData = CellData(opened: isOpen, title: category, sectionData: list)
            dataCell.append(cellData)
        }
        return dataCell
    }
    
    private func createCategoryCell(hero: DetailModel) -> [String: [String]] {
        var categoryData: [String: [String]] = [:]

        // Creamos un diccionario que mapea el nombre de cada categoría con su respectiva lista de nombres
        let categories: [String: [Any]] = [
            "Comics": hero.comics,
            "Series": hero.series,
            "Events": hero.events,
            "Stories": hero.stories
        ]

        // Recorremos el diccionario de categorías y transformamos los objetos a sus nombres
        for (categoryName, categoryItems) in categories {
            // Mapeamos los objetos a sus nombres o a un string indicando que no hay elementos
            let itemNames: [String]
            if let comicsItems = categoryItems as? [ComicsItem] {
                itemNames = comicsItems.map { $0.name }
            } else if let storiesItems = categoryItems as? [StoriesItem] {
                itemNames = storiesItems.map { $0.name }
            } else {
                itemNames = []
            }
            let categoryValues = itemNames.isEmpty ? ["", "No \(categoryName)"] : itemNames

            categoryData[categoryName] = categoryValues
            
            // Si hay un solo elemento en la lista, lo agregamos nuevamente para mantener la coherencia
            if categoryValues.count == 1 {
                categoryData[categoryName]?.append(categoryValues[0])
            }
        }

        return categoryData
    }



}
   
