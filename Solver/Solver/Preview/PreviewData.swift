//
//  PreviewData.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import Foundation
import SwiftUI

class PreviewData {
    let users: [UserEntity] = [
        UserEntity(id: "preview user", solvedCount: 13264, tier: 31, rating: 3311, userClass: 10, classDecoration: "gold", maxStreak: 24, rank: 1),
        UserEntity(id: "user", solvedCount: 97, tier: 11, rating: 827, userClass: 0, classDecoration: "none", maxStreak: 8, rank: 40303)
    ]
    
    let profile = ProfileEntity(imageUrl: "preview url", image: UIImage(named: "PreviewProfile")?.pngData())
    
    let badge = BadgeEntity(id: "lang-swift", name: "Swift", tier: "bronze", description: "Swift로 아무 문제나 해결", imageUrl: "preview url", image: UIImage(named: "PreviewBadge")?.pngData())
    
    let tags: [TagEntity] = [
        TagEntity(key: "data_structures", displayNames: [DisplayNameEntity(language: "ko", name: "자료 구조", short: "자료 구조")]),
        TagEntity(key: "stack", displayNames: [DisplayNameEntity(language: "ko", name: "스택", short: "스택")]),
        TagEntity(key: "dp", displayNames: [DisplayNameEntity(language: "ko", name: "다이나믹 프로그래밍", short: "다이나믹 프로그래밍")])
    ]
    
    lazy var items: [ItemEntity] = [
        ItemEntity(id: 1918, title: "후위 표기식", level: 14, tags: [tags[0], tags[1]]),
        ItemEntity(id: 17299, title: "오등큰수", level: 13, tags: [tags[0], tags[1]]),
        ItemEntity(id: 2133, title: "타일 채우기", level: 12, tags: [tags[2]])
    ]
    
    lazy var top100 = Top100Entity(count: 3, items: items)
    
    let problems: [ProblemEntity] = (0...30).map { level in
        ProblemEntity(level: level, total: 1000 - level * 30, solved: level % 8, tried: 0)
    }
}
