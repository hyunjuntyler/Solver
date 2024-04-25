//
//  ProblemDTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

struct ProblemDTO: Decodable {
    var level: Int
    var total: Int
    var solved: Int
    var partial: Int
    var tried: Int
}
