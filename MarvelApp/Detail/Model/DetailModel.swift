//
//  DetailModel.swift
//  MarvelApp
//
//  Created by Victor Marquez on 14/3/24.
//

import Foundation

struct DetailModel {
    let name:          String
    let backdropPath:  String?
    let description:   String
    let events:        [ComicsItem]
    let series:        [ComicsItem]
    let stories:       [StoriesItem]
    let comics:        [ComicsItem]
    
}

struct CellModel{
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
}
