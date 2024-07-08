//
//  SignUpStore.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

final class SignUpStore: ObservableObject {
    private let useCase = CheckUseCase()
    
    @Published var userId = ""
    @Published var showAlert = false
    @Published var isValid = true
    @Published var isLoading = false
    
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
