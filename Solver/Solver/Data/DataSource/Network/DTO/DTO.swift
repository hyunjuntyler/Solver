//
//  DTO.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

protocol DTO {
    associatedtype T
    
    func toDomain() -> T
}
