//
//  BadgeDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct BadgeDTO: Decodable {
    var badgeId: String
    var badgeImageUrl: String
    var displayName: String
    var displayDescription: String
    var badgeTier: String
}
