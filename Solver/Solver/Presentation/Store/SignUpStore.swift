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
    var isLoading = false
    
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
                isLoading = true
                try await useCase.check(id: userId)
                UserDefaults.standard.set(userId, forKey: "userId")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        UserDefaults.standard.set(false, forKey: "onboarding")
                        self.isLoading = false
                    }
                }
            } catch {
                Haptic.notification(type: .error)
                isLoading = false
                showAlert = true
            }
        }
    }
}
