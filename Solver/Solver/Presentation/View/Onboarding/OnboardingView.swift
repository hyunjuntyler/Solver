//
//  OnboardingView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var store = OnboardingStore()
    
    var body: some View {
        switch store.viewPhase {
        case .greeting:
            GreetingView()
        case .signUp:
            SignUpView()
        }
    }
}

#Preview {
    OnboardingView()
}
