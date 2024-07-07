//
//  ProblemsStore.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

final class ProblemsStore: ObservableObject {
    private let useCase = FetchUseCase()
    
    @Published var solvedCount = 0
    @Published var triedCount = 0
    @Published var problemsStats: [ProblemStats] = []
        
    private var isFetching = false
    
    init() {
        fetch()
    }
    
    init(problems: [ProblemEntity]) {
        update(problems)
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
                let problems = try await useCase.fetchProblem(userId: userId)
                DispatchQueue.main.async {
                    self.update(problems)
                }
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
        
        self.solvedCount = newSolvedCount
        self.triedCount = newTriedCount
        self.problemsStats = newProblemStats
    }
}

struct ProblemStats: Equatable {
    var tier: String
    var count: Int
    var color: Color
}
