//
//  ImageDownloader.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

protocol Downloader {
    func execute(_ url: String) async throws -> Data
}

class ImageDownloader: Downloader {
    func execute(_ url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        return data
    }
}
