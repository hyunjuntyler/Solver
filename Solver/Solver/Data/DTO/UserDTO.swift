//
//  UserDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class UserDTO: Decodable {
    var handle: String
    var bio: String
    var badgeId: String?
    var profileImageUrl: String?
    var solvedCount: Int
    var tier: Int
    var rating: Int
    var `class`: Int
    var classDecoration: String
    var maxStreak: Int
    var rank: Int
}
