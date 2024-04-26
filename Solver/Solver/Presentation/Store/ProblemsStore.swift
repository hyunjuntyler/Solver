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
    
    var solvedCount = 0
    var triedCount = 0
    var problems: [ProblemEntity] = []
    var problemsStats: [ProblemStats] = []
    var isLoading = false
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    init() { }
    
    init(problems: [ProblemEntity]) {
        self.problems = problems
        update(problems)
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
    
    func update(_ problems: [ProblemEntity]) {
        for problem in problems {
            solvedCount += problem.solved
            triedCount += problem.tried
            
            let level = problem.level
            let solved = problem.solved
            
            if let index = problemsStats.firstIndex(where: { $0.tier == level.tier }) {
                problemsStats[index].count += problem.solved
            } else {
                let problemStats = ProblemStats(tier: level.tier, count: solved, color: level.tierColor)
                problemsStats.append(problemStats)
            }
        }
    }
}

struct ProblemStats {
    var tier: String
    var count: Int
    var color: Color
}
