//
//  MainTabView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct MainTabView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("manual") private var manual = true

    @State private var userStore = UserStore()
    @StateObject private var problemsStore = ProblemsStore()
    @StateObject private var top100Store = Top100Store()
    
    var body: some View {
        TabView {
            SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
                .tabItem {
                    Label("내 정보", systemImage: "list.clipboard")
                }
            AccountView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
                .tabItem {
                    Label("계정", systemImage: "person.crop.circle")
                }
        }
        .tint(userStore.tint)
        .task(priority: .high) {
            userStore.modelContext = modelContext
            await userStore.fetchSwiftData {
                userStore.fetch()
            }
        }
        .sheet(isPresented: $manual) {
            ManualView()
                .interactiveDismissDisabled()
                .presentationCornerRadius(24)
        }
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: User.self, isAutosaveEnabled: false)
}
