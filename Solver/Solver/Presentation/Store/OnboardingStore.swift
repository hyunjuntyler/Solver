//
//  OnboardingStore.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

final class OnboardingStore: ObservableObject {
    @Published var viewPhase: ViewPhase = .greeting
    
    enum ViewPhase {
        case greeting
        case signUp
    }
    
    init() {
        changePhase()
    }
    
    private func changePhase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewPhase = .signUp
        }
    }
}
