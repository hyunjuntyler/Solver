//
//  Top100Entity.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct Top100Entity {
    var count: Int
    var items: [ItemEntity]
}

struct ItemEntity {
    var id: Int
    var title: String
    var level: Int
    var tags: [TagEntity]
}

struct TagEntity {
    var key: String
    var displayNames: [DisplayNameEntity]
}

struct DisplayNameEntity {
    var language: String
    var name: String
    var short: String
}
