//
//  CharacterDetail.swift
//  MarvelApp
//
//  Created by Victor Marquez on 13/3/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let characterDetail = try? JSONDecoder().decode(CharacterDetail.self, from: jsonData)

import Foundation

// MARK: - CharacterDetail
struct CharacterDetail: Codable {
    let code: Int
    let attributionHTML: String
    let data: DataClass
    let etag, status, copyright, attributionText: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let count, limit, offset: Int
    let results: [Result]
    let total: Int
}

// MARK: - Result
struct Result: Codable {
    let comics: Comics
    let description: String
    let events: Comics
    let id: Int
    let modified: String
    let name: String
    let resourceURI: String
    let series: Comics
    let stories: Stories
    let thumbnail: Thumbnail
    let urls: [URLElement]
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let name: String
    let resourceURI: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let name: String
    let resourceURI: String
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case cover = "cover"
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let thumbnailExtension: String
    let path: String

    enum CodingKeys: String, CodingKey {
        case thumbnailExtension = "extension"
        case path
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String
    let url: String
}
