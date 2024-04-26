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
    var isLoading = false
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    func fetch() {
        isLoading = true
        
        Task {
            do {
                top100 = try await useCase.fetchTop100(userId: userId)
                isLoading = false
            } catch {
                isLoading = true
            }
        }
    }
}
