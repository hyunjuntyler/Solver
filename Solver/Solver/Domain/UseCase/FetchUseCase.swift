//
//  FetchUseCase.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class FetchUseCase {
    private let repository = FetchRepository()
    
    func fetchSite() async throws -> Int {
        let site = try await repository.fetchSite()
        return site.userCount
    }
    
    func fetchUser(id: String) async throws -> UserEntity {
        try await repository.fetchUser(id: id)
    }
    
    func fetchProfile(cache: String, url: String) async throws -> ProfileEntity {
        try await repository.fetchProfile(url: url)
    }
    
    func fetchBadge(cache: String, badgeId: String) async throws -> BadgeEntity {
        try await repository.fetchBadge(badgeId: badgeId)
    }
    
    func fetchProblem(id: String) async throws -> [ProblemEntity] {
        try await repository.fetchProblems(id: id)
    }
    
    func fetchTop100(id: String) async throws -> Top100Entity {
        try await repository.fetchTop100(id: id)
    }
}
