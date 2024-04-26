//
//  FetchRepository.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class FetchRepository {
    private let networkClient = NetworkClient()
    
    func fetchSite() async throws -> SiteEntity {
        let endpoint = APIEndpoint.fetchSiteStats
        
        let siteDTO: SiteDTO = try await networkClient.request(endpoint: endpoint)
        return siteDTO.toDomain()
    }
    
    func fetchUser(userId: String) async throws -> UserEntity {
        let userEndpoint = APIEndpoint.fetchUser(userId: userId)
        let userDTO: UserDTO = try await networkClient.request(endpoint: userEndpoint)
        
        return userDTO.toDomain()
    }
    
    func fetchProblems(userId: String) async throws -> [ProblemEntity] {
        let problemEndpoint = APIEndpoint.fetchProblems(userId: userId)
        let problemsDTO: [ProblemDTO] = try await networkClient.request(endpoint: problemEndpoint)
        
        return problemsDTO.map { $0.toDomain() }
    }
    
    func fetchTop100(userId: String) async throws -> Top100Entity {
        let top100Endpoint = APIEndpoint.fetchTop100(userId: userId)
        let top100DTO: Top100DTO = try await networkClient.request(endpoint: top100Endpoint)

        return top100DTO.toDomain()
    }
    
    func fetchBadge(badgeId: String) async throws -> BadgeEntity {
        let badgeEndpoint = APIEndpoint.fetchBadge(badgeId: badgeId)
        let badgeDTO: BadgeDTO = try await networkClient.request(endpoint: badgeEndpoint)
        
        var fetchedBadge = badgeDTO.toDomain()
        fetchedBadge.image = try await ImageDownloader().execute(fetchedBadge.imageUrl)
        
        return fetchedBadge
    }
    
    func fetchProfile(url: String) async throws -> ProfileEntity {
        var fetchedProfile = ProfileEntity(imageUrl: url)
        fetchedProfile.image = try await ImageDownloader().execute(url)
        
        return fetchedProfile
    }
}
