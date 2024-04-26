//
//  NetworkError.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

enum NetworkError: Error {
    case invalidID
    case invalidURL
    case invalidResponse
    case invalidData
}
