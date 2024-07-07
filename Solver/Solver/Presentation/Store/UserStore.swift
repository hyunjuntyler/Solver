//
//  UserStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI
import WidgetKit

final class UserStore: ObservableObject {
    private let useCase = FetchUseCase()
        
    @Published var user: UserEntity?
    @Published var profile: ProfileEntity?
    @Published var badge: BadgeEntity?
    @Published var userCount: Int?
    @Published var tint: Color = .accent
    @Published var isFetching = false
        
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
        guard !isFetching else { return }
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("Failed to retrieve userId from UserDefaults")
            return
        }
        let storedProfileImageUrl = profile?.imageUrl
        let storedBadgeId = badge?.id
        
        isFetching = true
        
        Task {
            defer {
                DispatchQueue.main.async {
                    self.isFetching = false
                }
            }
            do {
                let fetchedUserCount = try await useCase.fetchSite()
                let fetchedUser = try await useCase.fetchUser(userId: userId)
                
                DispatchQueue.main.async {
                    self.userCount = fetchedUserCount
                    self.user = fetchedUser
                }
                
                if let url = fetchedUser.profileImageUrl {
                    if storedProfileImageUrl != url {
                        let fetchedProfile = try await useCase.fetchProfile(url: url)
                        DispatchQueue.main.async {
                            self.profile = fetchedProfile
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.profile = nil
                    }
                }
                
                if let badgeId = fetchedUser.badgeId {
                    if storedBadgeId != badgeId {
                        let fetchedBadge = try await useCase.fetchBadge(badgeId: badgeId)
                        DispatchQueue.main.async {
                            self.badge = fetchedBadge
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.badge = nil
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateTintColor()
                }
            } catch {
                print("Error to fetch user")
            }
        }
    }
    
    private func updateTintColor() {
        if let color = user?.tier.tierColor {
            tint = color
        }
    }
}
