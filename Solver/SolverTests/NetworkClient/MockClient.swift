//
//  MockClient.swift
//  SolverTests
//
//  Created by hyunjun on 6/23/24.
//

import Foundation

class MockClient: Client {
    var data: Data?
    var error: Error?
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        if let error = error {
            throw error
        }
        
        guard let data = data else {
            throw NetworkError.invalidData
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
