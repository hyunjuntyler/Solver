//
//  NetworkClient.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

protocol Client {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

class NetworkClient: Client {
    func request(endpoint: Endpoint) async throws {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        let (_, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
    }
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.invalidData
        }
    }
}
