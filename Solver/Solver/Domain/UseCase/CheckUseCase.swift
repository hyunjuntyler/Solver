//
//  CheckUseCase.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class CheckUseCase {
    private let repository = CheckRepository()
    
    func check(id: String) async throws {
        try await repository.checkUserIsValid(id: id)
    }
}
