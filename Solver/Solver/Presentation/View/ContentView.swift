//
//  ContentView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") private var onboarding = true
    @AppStorage("manual") private var manual = true
    
    var body: some View {
        if onboarding {
            OnboardingView()
        } else {
            MainView()
                .sheet(isPresented: $manual) {
                    ManualView()
                        .interactiveDismissDisabled()
                        .presentationCornerRadius(24)
                }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
