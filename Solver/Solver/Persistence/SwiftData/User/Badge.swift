//
//  Badge.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftData
import SwiftUI

@Model
final class Badge {
    var user: User?
    var id: String
    var name: String
    var tier: String
    var condition: String
    var imageUrl: String
    var image: Data?
    
    init(user: User? = nil, id: String, name: String, tier: String, condition: String, imageUrl: String, image: Data? = nil) {
        self.user = user
        self.id = id
        self.name = name
        self.tier = tier
        self.condition = condition
        self.imageUrl = imageUrl
        self.image = image
    }
    
    convenience init(from entity: BadgeEntity) {
        self.init(
            id: entity.id,
            name: entity.name,
            tier: entity.tier,
            condition: entity.description,
            imageUrl: entity.imageUrl,
            image: entity.image
        )
    }
    
    func toDomain() -> BadgeEntity {
        BadgeEntity(
            id: id,
            name: name,
            tier: tier,
            description: condition,
            imageUrl: imageUrl,
            image: image
        )
    }
}
