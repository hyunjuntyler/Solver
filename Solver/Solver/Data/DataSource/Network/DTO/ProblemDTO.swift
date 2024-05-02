//
//  ProblemDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct ProblemDTO: Decodable, DTO {
    var level: Int
    var total: Int
    var solved: Int
    var partial: Int
    var tried: Int
    
    func toDomain() -> ProblemEntity {
        ProblemEntity(
            level: level,
            total: total,
            solved: solved,
            tried: tried
        )
    }
}
