//
//  PreviewContainer.swift
//  Solver
//
//  Created by hyunjun on 7/7/24.
//

import SwiftUI
import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        container.mainContext.insert(SampleData.user)
        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()

struct SampleData {
    static let user = User(
        id: "useruseruseruseruser",
        solvedCount: 192,
        tier: 11,
        rating: 827,
        userClass: 3,
        classDecoration: "none",
        maxStreak: 20,
        rank: 30200,
        profile: profile,
        badge: badge
    )
    
    static let badge = Badge(
        id: "lang-swift",
        name: "Swift",
        tier: "bronze",
        condition: "Swift로 아무 문제나 해결",
        imageUrl: "preview url",
        image: UIImage(named: "PreviewBadge")?.pngData()
    )
    
    static let profile = Profile(
        imageUrl: "preview url",
        image: UIImage(named: "PreviewProfile")?.pngData()
    )
}

