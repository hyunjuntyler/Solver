//
//  User.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftData
import SwiftUI

@Model
final class User {
    @Attribute(.unique) var id: String
    var badgeId: String?
    var profileImageUrl: String?
    var solvedCount: Int
    var tier: Int
    var rating: Int
    var userClass: Int
    var classDecoration: String
    var maxStreak: Int
    var rank: Int
    
    @Relationship(deleteRule: .cascade, inverse: \Profile.user) var profile: Profile?
    @Relationship(deleteRule: .cascade, inverse: \Badge.user) var badge: Badge?
    var totalUserCount: Int?
    
    init(id: String, badgeId: String? = nil, profileImageUrl: String? = nil, solvedCount: Int, tier: Int, rating: Int, userClass: Int, classDecoration: String, maxStreak: Int, rank: Int, profile: Profile? = nil, badge: Badge? = nil, totalUserCount: Int? = nil) {
        self.id = id
        self.badgeId = badgeId
        self.profileImageUrl = profileImageUrl
        self.solvedCount = solvedCount
        self.tier = tier
        self.rating = rating
        self.userClass = userClass
        self.classDecoration = classDecoration
        self.maxStreak = maxStreak
        self.rank = rank
        self.profile = profile
        self.badge = badge
        self.totalUserCount = totalUserCount
    }
    
    convenience init(from entity: UserEntity) {
        self.init(
            id: entity.id,
            badgeId: entity.badgeId,
            profileImageUrl: entity.profileImageUrl,
            solvedCount: entity.solvedCount,
            tier: entity.tier,
            rating: entity.rating,
            userClass: entity.userClass,
            classDecoration: entity.classDecoration,
            maxStreak: entity.maxStreak,
            rank: entity.rank
        )
    }
    
    func toDomain() -> UserEntity {
        UserEntity(
            id: id,
            badgeId: badgeId,
            profileImageUrl: profileImageUrl,
            solvedCount: solvedCount,
            tier: tier,
            rating: rating,
            userClass: userClass,
            classDecoration: classDecoration,
            maxStreak: maxStreak,
            rank: rank
        )
    }
}
