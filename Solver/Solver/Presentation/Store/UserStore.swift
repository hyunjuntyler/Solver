//
//  UserStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI
import SwiftData
import WidgetKit

@Observable
final class UserStore {
    private let useCase = FetchUseCase()
    
    var modelContext: ModelContext?
    
    var user: UserEntity?
    var profile: ProfileEntity?
    var badge: BadgeEntity?
    var userCount: Int?
    var isLoading = false
    var tint: Color = .accent
    
    let required: [Double] = [0, 30, 60, 90, 120, 150, 200, 300, 400, 500, 650, 800, 950, 1100, 1250, 1400, 1600, 1750, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2850, 2900, 2950, 3000, 3000.1]
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    init() { }
    
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
                
                saveSwiftData()
                updateTintColor()
                isLoading = false
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                isLoading = true
            }
        }
    }
    
    private func updateTintColor() {
        if let color = user?.tier.tierColor {
            tint = color
        }
    }
}

extension UserStore {
    func fetchSwiftData() {
        guard let modelContext else { return }
        let fetchDescriptor = FetchDescriptor<User>()
        do {
            let persistanceUser = try modelContext.fetch(fetchDescriptor)
            if let storedUser = persistanceUser.first {
                user = storedUser.toDomain()
                profile = storedUser.profile?.toDomain()
                badge = storedUser.badge?.toDomain()
                userCount = storedUser.totalUserCount
            }
        } catch {
            print("Error to get persistence user")
        }
    }
    
    func saveSwiftData() {
        guard let fetchedUser = user else { return }
        let user = User(
            id: fetchedUser.id,
            solvedCount: fetchedUser.solvedCount,
            tier: fetchedUser.tier,
            rating: fetchedUser.rating,
            userClass: fetchedUser.userClass,
            classDecoration: fetchedUser.classDecoration,
            maxStreak: fetchedUser.maxStreak,
            rank: fetchedUser.rank,
            totalUserCount: userCount
        )
        
        if let fetchedBadge = badge {
            user.badge = Badge(
                id: fetchedBadge.id,
                name: fetchedBadge.name,
                tier: fetchedBadge.tier,
                condition: fetchedBadge.description,
                imageUrl: fetchedBadge.imageUrl,
                image: fetchedBadge.image
            )
        }
        
        if let fetchedProfile = profile {
            user.profile = Profile(
                imageUrl: fetchedProfile.imageUrl,
                image: fetchedProfile.image
            )
        }
        
        guard let modelContext else { return }
        let fetchDescriptor = FetchDescriptor<User>()
        
        do {
            let persistanceUser = try modelContext.fetch(fetchDescriptor)
            if let storedUser = persistanceUser.first {
                modelContext.delete(storedUser)
            }
        } catch {
            print("Error to get persistence user")
        }
        
        modelContext.insert(user)
        
        do {
            try modelContext.save()
        } catch {
            print("Error to save persistence user")
        }
    }
}
