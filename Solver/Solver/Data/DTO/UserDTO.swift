//
//  UserDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class UserDTO: Decodable, DTO {
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
    
    func toDomain() -> UserEntity {
        UserEntity(
            id: handle,
            badgeId: badgeId,
            profileImageUrl: profileImageUrl,
            solvedCount: solvedCount,
            tier: tier,
            rating: rating,
            userClass: `class`,
            classDecoration: classDecoration,
            maxStreak: maxStreak,
            rank: rank
        )
    }
}
