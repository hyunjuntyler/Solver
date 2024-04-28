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
    
    init() {
        fetch()
    }
    
    init(user: UserEntity, profile: ProfileEntity, badge: BadgeEntity) {
        self.user = user
        self.profile = profile
        self.badge = badge
        self.userCount = 135279
    }
    
    func fetch() {
        let storedProfileImageUrl = profile?.imageUrl
        let storedBadgeId = badge?.id
        
        Task {
            isLoading = true
            
            do {
                userCount = try await useCase.fetchSite()
                user = try await useCase.fetchUser(userId: userId)
                
                if let url = user?.profileImageUrl {
                    if storedProfileImageUrl != url {
                        profile = try await useCase.fetchProfile(url: url)
                    }
                } else {
                    profile = nil
                }
                
                if let badgeId = user?.badgeId {
                    if storedBadgeId != badgeId {
                        badge = try await useCase.fetchBadge(badgeId: badgeId)
                    }
                } else {
                    badge = nil
                }
                
                isLoading = false
            } catch {
                isLoading = true
            }
        }
    }
}
