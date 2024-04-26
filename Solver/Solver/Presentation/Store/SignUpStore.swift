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
    
    func checkIsValid() {
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

struct signUpButtonStyle: ButtonStyle {
    var disable: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(disable ? .gray : .white)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundStyle(disable ? Color(.systemGray5) : .accentColor)
            }
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.bouncy, value: configuration.isPressed)
            .animation(.bouncy, value: disable)
    }
}
