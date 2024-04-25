//
//  ContentView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") private var onboarding = true
    
    var body: some View {
        if onboarding {
            OnboardingView()
        } else {
            MainTabView()
        }
    }
}

#Preview {
    ContentView()
}
