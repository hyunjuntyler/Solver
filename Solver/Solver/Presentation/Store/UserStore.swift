//
//  UserStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI
import SwiftData
import WidgetKit

final class UserStore: ObservableObject {
    private let useCase = FetchUseCase()
    
    var modelContext: ModelContext?
    
    @Published var user: UserEntity?
    @Published var profile: ProfileEntity?
    @Published var badge: BadgeEntity?
    @Published var userCount: Int?
    @Published var tint: Color = .accent
    
    private var isFetching = false
        
    init() { }
    
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
                
//                saveSwiftData()
                DispatchQueue.main.async {
                    self.updateTintColor()
                }
                WidgetCenter.shared.reloadAllTimelines()
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

extension UserStore {
    func fetchSwiftData(completion: @escaping () -> Void) async {
        guard let modelContext else { return }
        let fetchDescriptor = FetchDescriptor<User>()
        do {
            let persistanceUser = try modelContext.fetch(fetchDescriptor)
            print(persistanceUser.count)
            if let storedUser = persistanceUser.first {
                user = storedUser.toDomain()
                profile = storedUser.profile?.toDomain()
                badge = storedUser.badge?.toDomain()
                userCount = storedUser.totalUserCount
            }
            updateTintColor()
            print("complete")
            completion()
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
