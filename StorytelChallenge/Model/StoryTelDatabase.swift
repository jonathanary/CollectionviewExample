//
//  StoryTelDatabase.swift
//  StorytelChallenge
//
//  Created by Jonathan on 2019. 05. 16..
//  Copyright © 2019. Jonathan. All rights reserved.
//

import Foundation

struct StoryTelDatabase: Codable {
    let query: String
    let nextPage: String?
    let totalCount: Int?
    let items: [Item]?
}

struct Item: Codable {
    let id, title, originalTitle: String?
    let description: String?
    let authors, narrators, translators: [Creatives]?
    let rating: Double?
    let reviewCount: Int?
    let language: Language?
    let cover: Cover?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, originalTitle, description, authors, narrators, translators, rating, reviewCount, language, cover, tags
    }
}

struct Creatives: Codable, Hashable {
    let id, name: String?
}

struct Language: Codable, Hashable {
    let id, name: String?
}


struct Cover: Codable {
    let url: String
    let width, height: Int
}

struct Format: Codable {
    let id, isbn: String?
    let releaseDate, enterServiceDate: Date?
    let abridged, searchable: Bool?
    let isReleased: Bool?
    let length: Int?
    let cover: Cover?
}
