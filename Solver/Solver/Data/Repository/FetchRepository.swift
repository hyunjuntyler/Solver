//
//  FetchRepository.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import Foundation

class FetchRepository {
    private let apiClient = APIClient()
    
    func fetchSite() async throws -> SiteEntity {
        let endpoint = APIEndpoint.fetchSite
        
        let siteDTO: SiteDTO = try await apiClient.request(endpoint: endpoint)
        return siteDTO.toDomain()
    }
    
    func fetchUser(id: String) async throws -> UserEntity {
        let userEndpoint = APIEndpoint.fetchUser(userId: id)
        let userDTO: UserDTO = try await apiClient.request(endpoint: userEndpoint)
        
        return userDTO.toDomain()
    }
    
    func fetchProblems(id: String) async throws -> [ProblemEntity] {
        let problemEndpoint = APIEndpoint.fetchProblems(userId: id)
        let problemsDTO: [ProblemDTO] = try await apiClient.request(endpoint: problemEndpoint)
        
        return problemsDTO.map { $0.toDomain() }
    }
    
    func fetchTop100(id: String) async throws -> Top100Entity {
        let top100Endpoint = APIEndpoint.fetchTop100(userId: id)
        let top100DTO: Top100DTO = try await apiClient.request(endpoint: top100Endpoint)

        return top100DTO.toDomain()
    }
    
    func fetchBadge(badgeId: String) async throws -> BadgeEntity {
        let badgeEndpoint = APIEndpoint.fetchBadge(badgeId: badgeId)
        let badgeDTO: BadgeDTO = try await apiClient.request(endpoint: badgeEndpoint)
        
        var fetchedBadge = badgeDTO.toDomain()
        fetchedBadge.image = try await ImageDataLoader().loadImageData(fetchedBadge.imageUrl)
        
        return fetchedBadge
    }
    
    func fetchProfile(url: String) async throws -> ProfileEntity {
        var fetchedProfile = ProfileEntity(imageUrl: url)
        fetchedProfile.image = try await ImageDataLoader().loadImageData(url)
        
        return fetchedProfile
    }
}
