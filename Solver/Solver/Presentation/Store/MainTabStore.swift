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
    
    var userId = UserDefaults.standard.string(forKey: "userId")
    var user: UserEntity?
    var profile: ProfileEntity?
    var badge: BadgeEntity?
    var top100: Top100Entity?
    var problems: [ProblemEntity]?
    var userCount: Int?
    
    init() {
        fetch()
    }
    
    func fetch() {
        fetchUser()
        fetchTop100()
        fetchProblem()
    }
    
    func fetchUser() {
        guard let id = userId else { return }

        Task {
            do {
                userCount = try await useCase.fetchSite()
                user = try await useCase.fetchUser(id: id)
                
                if let url = user?.profileImageUrl {
                    profile = try await useCase.fetchProfile(cache: "", url: url)
                }
                
                if let badgeId = user?.badgeId {
                    badge = try await useCase.fetchBadge(cache: "", badgeId: badgeId)
                }
            } catch {
                print("error to load user")
            }
        }
    }
    
    func fetchProblem() {
        guard let id = userId else { return }

        Task {
            do {
                problems = try await useCase.fetchProblem(id: id)
            } catch {
                print("error to load problem")
            }
        }
    }
    
    func fetchTop100() {
        guard let id = userId else { return }
        
        Task {
            do {
                top100 = try await useCase.fetchTop100(id: id)
            } catch {
                print("error to load top100")
            }
        }
    }
}
