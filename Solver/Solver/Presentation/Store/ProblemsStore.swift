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
    var problemsStats: [ProblemStats] = []
    
    @ObservationIgnored
    @AppStorage("userId") var userId = ""
    
    init() { 
        fetch()
    }
    
    init(problems: [ProblemEntity]) {
        update(problems)
    }
    
    func fetch() {
        Task {
            do {
                let problems = try await useCase.fetchProblem(userId: userId)
                update(problems)
            } catch {
                print("Error to fetch problems")
            }
        }
    }
    
    func update(_ problems: [ProblemEntity]) {
        var newProblemStats: [ProblemStats] = []
        var newSolvedCount = 0
        var newTriedCount = 0
        
        for problem in problems {
            if problem.level == 0 { continue }
            newSolvedCount += problem.solved
            newTriedCount += problem.tried
            
            let level = problem.level
            let solved = problem.solved
            
            if let index = newProblemStats.firstIndex(where: { $0.tier == level.tier }) {
                newProblemStats[index].count += problem.solved
            } else {
                let problemStats = ProblemStats(tier: level.tier, count: solved, color: level.tierColor)
                newProblemStats.append(problemStats)
            }
        }
        
        solvedCount = newSolvedCount
        triedCount = newTriedCount
        problemsStats = newProblemStats
    }
}

struct ProblemStats: Equatable {
    var tier: String
    var count: Int
    var color: Color
}
