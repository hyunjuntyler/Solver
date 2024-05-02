//
//  CheckRepository.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class CheckRepository {
    private let networkClient = NetworkClient()
    
    func checkUserIsValid(id: String) async throws {
        let endpoint = APIEndpoint.checkUser(userId: id)
        try await networkClient.request(endpoint: endpoint)
    }
}
