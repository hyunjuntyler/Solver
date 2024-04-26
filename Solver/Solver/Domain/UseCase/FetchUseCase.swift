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
    
    func fetchUser(userId: String) async throws -> UserEntity {
        try await repository.fetchUser(userId: userId)
    }
    
    func fetchProfile(url: String) async throws -> ProfileEntity {
        try await repository.fetchProfile(url: url)
    }
    
    func fetchBadge(badgeId: String) async throws -> BadgeEntity {
        try await repository.fetchBadge(badgeId: badgeId)
    }
    
    func fetchProblem(userId: String) async throws -> [ProblemEntity] {
        try await repository.fetchProblems(userId: userId)
    }
    
    func fetchTop100(userId: String) async throws -> Top100Entity {
        try await repository.fetchTop100(userId: userId)
    }
}
