//
//  MainTabStore.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

@Observable
final class MainTabStore {
    let useCase = FetchUseCase()
    
    var userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    var profileImage: UIImage?
    var badgeImage: UIImage?
    var tier: Int?
    var solvedCount: Int?
    var maxStreak: Int?
    var rank: Int?
    var rankRatio: Int?
    var userClass: Int?
    var problemCount: Int?
    var top100Count: Int?
    
    init() {
        fetch()
    }
    
    init(preview: Bool) {
        userId = "hello"
        tier = 7
        solvedCount = 100
        maxStreak = 20
        rank = 100
        rankRatio = 20
        userClass = 2
        problemCount = 50
        top100Count = 100
    }
    
    func fetch() {
        fetchUser()
        fetchTop100()
        fetchProblem()
    }
    
    func fetchUser() {
        Task {
            do {
                let userCount = try await useCase.fetchSite()
                let user = try await useCase.fetchUser(id: userId)
                tier = user.tier
                solvedCount = user.solvedCount
                maxStreak = user.maxStreak
                rank = user.rank
                rankRatio = Int(Double(user.rank) / Double(userCount) * 100)
                userClass = user.userClass
                
                if let url = user.profileImageUrl {
                    let profile = try await useCase.fetchProfile(cache: "", url: url)
                    if let data = profile.image {
                        profileImage = UIImage(data: data)
                    }
                }
                
                if let badgeId = user.badgeId {
                    let badge = try await useCase.fetchBadge(cache: "", badgeId: badgeId)
                    if let data = badge.image {
                        badgeImage = UIImage(data: data)
                    }
                }
            } catch {
                print("error to load user")
            }
        }
    }
    
    func fetchProblem() {
        Task {
            do {
                let problems = try await useCase.fetchProblem(id: userId)
                problemCount = problems.count
            } catch {
                print("error to load problem")
            }
        }
    }
    
    func fetchTop100() {
        Task {
            do {
                let top100 = try await useCase.fetchTop100(id: userId)
                top100Count = top100.count
            } catch {
                print("error to load top100")
            }
        }
    }
}
