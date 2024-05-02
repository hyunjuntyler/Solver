//
//  Top100Store.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

@Observable
final class Top100Store {
    let useCase = FetchUseCase()
    
    var top100: Top100Entity?
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    init() { 
        fetch()
    }
    
    init(top100: Top100Entity) {
        self.top100 = top100
    }
    
    func fetch() {
        Task {
            do {
                let fetchedTop100 = try await useCase.fetchTop100(userId: userId)
                top100 = fetchedTop100
            } catch {
                print("Error to fetch top100")
            }
        }
    }
}
