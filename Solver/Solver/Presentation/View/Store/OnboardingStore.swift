//
//  OnboardingStore.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

@Observable
final class OnboardingStore {
    private let useCase = CheckUseCase()

    var userId = ""
    var showAlert = false
    var viewPhase: ViewPhase = .greeting
    
    enum ViewPhase {
        case greeting
        case signUp
    }
    
    init() {
        changePhase()
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
    
    private func changePhase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewPhase = .signUp
        }
    }
}
