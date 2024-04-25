//
//  BadgeDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct BadgeDTO: Decodable, DTO {
    var badgeId: String
    var badgeImageUrl: String
    var displayName: String
    var displayDescription: String
    var badgeTier: String
    
    func toDomain() -> BadgeEntity {
        BadgeEntity(
            id: badgeId,
            name: displayName,
            tier: badgeTier,
            description: displayDescription,
            imageUrl: badgeImageUrl
        )
    }
}
