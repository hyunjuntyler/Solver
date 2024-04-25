//
//  Top100DTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct Top100DTO: Decodable {
    var count: Int
    var items: [Item]
}

struct Item: Decodable {
    var problemId: Int
    var titleKo: String
    var titles: [Title]
    var level: Int
    var tags: [Tag]
}

struct Title: Decodable {
    var language: String
    var languageDisplayName: String
    var title: String
}

struct Tag: Decodable {
    var key: String
    var bojTagId: Int
    var problemCount: Int
    var displayNames: [DisplayName]
    var aliases: [Alias]
}

struct DisplayName: Decodable {
    var language: String
    var name: String
    var short: String
}

struct Alias: Decodable {
    var alias: String
}
