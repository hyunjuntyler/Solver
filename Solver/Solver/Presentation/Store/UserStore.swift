//
//  UserStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

@Observable
final class UserStore {
    private let useCase = FetchUseCase()
    
    var user: UserEntity?
    var profile: ProfileEntity?
    var badge: BadgeEntity?
    var userCount: Int?
    var isLoading = false
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    func fetch() {
        Task {
            isLoading = true
            
            do {
                userCount = try await useCase.fetchSite()
                user = try await useCase.fetchUser(id: userId)
                
                if let url = user?.profileImageUrl {
                    profile = try await useCase.fetchProfile(cache: "", url: url)
                }
                
                if let badgeId = user?.badgeId {
                    badge = try await useCase.fetchBadge(cache: "", badgeId: badgeId)
                }
                
                isLoading = false
            } catch {
                isLoading = true
            }
        }
    }
}
