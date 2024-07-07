//
//  Top100Store.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

final class Top100Store: ObservableObject {
    private let useCase = FetchUseCase()
    
    @Published var top100: Top100Entity?
    @Published var isFetching = false
    
    init() {
        fetch()
    }
    
    init(top100: Top100Entity) {
        self.top100 = top100
    }
    
    func fetch() {
        guard !isFetching else { return }
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("Failed to retrieve userId from UserDefaults")
            return
        }
        
        isFetching = true
        
        Task {
            defer {
                DispatchQueue.main.async {
                    self.isFetching = false
                }
            }
            do {
                let fetchedTop100 = try await useCase.fetchTop100(userId: userId)
                DispatchQueue.main.async {
                    self.top100 = fetchedTop100
                }
            } catch {
                print("Error to fetch top100")
            }
        }
    }
}
