//
//  APIEndpoint.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
}

enum APIEndpoint: Endpoint {
    case checkUser(userId: String)
    case fetchUser(userId: String)
    case fetchProblems(userId: String)
    case fetchTop100(userId: String)
    case fetchBadge(badgeId: String)
    case fetchSite
    
    var baseURL: String { "https://solved.ac/api/v3" }
    var path: String {
        switch self {
        case .checkUser(let userId), .fetchUser(let userId): return "/user/show?handle=\(userId)"
        case .fetchProblems(let userId): return "/user/problem_stats?handle=\(userId)"
        case .fetchTop100(let userId): return "/user/top_100?handle=\(userId)"
        case .fetchBadge(let badgeId): return "/badge/show?badgeId=\(badgeId)"
        case .fetchSite: return "/site/stats"
        }
    }
}
