//
//  ProblemsStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

@Observable
final class ProblemsStore {
    let useCase = FetchUseCase()
    
    var problems: [ProblemEntity]? = []
    var isLoading = false
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    init() { }
    
    init(problems: [ProblemEntity]) {
        self.problems = problems
    }
    
    func fetch() {
        isLoading = true
        
        Task {
            do {
                problems = try await useCase.fetchProblem(userId: userId)
                isLoading = false
            } catch {
                isLoading = true
            }
        }
    }
}
