//
//  Comics.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let comicModel = try? JSONDecoder().decode(ComicModel.self, from: jsonData)

import Foundation

// MARK: - ComicsResponse
struct ComicsResponse: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: String
    let results: [Comics]
}

// MARK: - Result
struct Comics: Codable {
    let id, digitalID, title, issueNumber: String
    let variantDescription, description, modified, isbn: String
    let upc, diamondCode, ean, issn: String
    let format, pageCount: String
    let textObjects: [TextObject]
    let resourceURI: String
    let urls: [URLElement]
    let series: Series
    let variants, collections, collectedIssues: [Series]
    let dates: [DateElement]
    let prices: [Price]
    let thumbnail: Thumbnail
    let images: [Thumbnail]
    let creators, characters: Characters
    let stories: Stories
    let events: Events

    enum CodingKeys: String, CodingKey {
        case id
        case digitalID = "digitalId"
        case title, issueNumber, variantDescription, description, modified, isbn, upc, diamondCode, ean, issn, format, pageCount, textObjects, resourceURI, urls, series, variants, collections, collectedIssues, dates, prices, thumbnail, images, creators, characters, stories, events
    }
}

// MARK: - Characters
struct Characters: Codable {
    let available, returned, collectionURI: String
    let items: [CharactersItem]
}

// MARK: - CharactersItem
struct CharactersItem: Codable {
    let resourceURI, name, role: String
}

// MARK: - Series
struct Series: Codable {
    let resourceURI, name: String
}

// MARK: - DateElement
struct DateElement: Codable {
    let type, date: String
}

// MARK: - Events
struct Events: Codable {
    let available, returned, collectionURI: String
    let items: [Series]
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - Price
struct Price: Codable {
    let type, price: String
}

// MARK: - Stories
struct Stories: Codable {
    let available, returned, collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}

// MARK: - TextObject
struct TextObject: Codable {
    let type, language, text: String
}

// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String
}
