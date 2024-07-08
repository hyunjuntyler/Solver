//
//  Profile.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftData
import SwiftUI

@Model
final class Profile {
    var user: User?
    var imageUrl: String
    var image: Data?
    
    init(user: User? = nil, imageUrl: String, image: Data? = nil) {
        self.user = user
        self.imageUrl = imageUrl
        self.image = image
    }
    
    convenience init(from entity: ProfileEntity) {
        self.init(
            imageUrl: entity.imageUrl,
            image: entity.image
        )
    }
    
    func toDomain() -> ProfileEntity {
        ProfileEntity(
            imageUrl: imageUrl,
            image: image
        )
    }
}
