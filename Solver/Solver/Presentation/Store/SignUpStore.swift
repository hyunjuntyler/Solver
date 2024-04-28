//
//  SignUpStore.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

@Observable
final class SignUpStore {
    private let useCase = CheckUseCase()
    
    var userId = ""
    var showAlert = false
    var isValid = true
    
    func validateUserId() {
        let pattern = "^[a-zA-Z0-9_]*$"
        
        if userId.range(of: pattern, options: .regularExpression) != nil {
            isValid = true
        } else {
            isValid = false
        }
    }
    
    func checkUserId() {
        Task {
            do {
                try await useCase.check(id: userId)
                UserDefaults.standard.set(userId, forKey: "userId")
                UserDefaults.standard.set(false, forKey: "onboarding")
            } catch {
                showAlert = true
            }
        }
    }
}
