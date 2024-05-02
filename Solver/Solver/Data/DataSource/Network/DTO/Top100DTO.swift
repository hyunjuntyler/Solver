//
//  Top100DTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct Top100DTO: Decodable, DTO {
    var count: Int
    var items: [Item]
    
    func toDomain() -> Top100Entity {
        Top100Entity(
            count: count,
            items: items.map { $0.toDomain() }
        )
    }
}

struct Item: Decodable, DTO {
    var problemId: Int
    var titleKo: String
    var titles: [Title]
    var level: Int
    var tags: [Tag]
    
    func toDomain() -> ItemEntity {
        ItemEntity(
            id: problemId, title: titleKo,
            level: level, tags: tags.map { $0.toDomain() }
        )
    }
}

struct Title: Decodable {
    var language: String
    var languageDisplayName: String
    var title: String
}

struct Tag: Decodable, DTO {
    var key: String
    var bojTagId: Int
    var problemCount: Int
    var displayNames: [DisplayName]
    var aliases: [Alias]
    
    func toDomain() -> TagEntity {
        TagEntity(
            key: key,
            displayNames: displayNames.map { $0.toDomain() }
        )
    }
}

struct DisplayName: Decodable, DTO {
    var language: String
    var name: String
    var short: String
    
    func toDomain() -> DisplayNameEntity {
        DisplayNameEntity(
            language: language,
            name: name,
            short: short
        )
    }
}

struct Alias: Decodable {
    var alias: String
}
