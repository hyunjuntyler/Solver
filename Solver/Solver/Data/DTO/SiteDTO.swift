//
//  SiteDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct SiteDTO: Decodable, DTO {
    var userCount: Int
    
    func toDomain() -> SiteEntity {
        SiteEntity(
            userCount: userCount
        )
    }
}
