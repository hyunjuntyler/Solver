//
//  MainView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI
import SwiftData
import WidgetKit

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    private var user: User? { users.first }
    
    @StateObject private var userStore = UserStore()
    @StateObject private var problemsStore = ProblemsStore()
    @StateObject private var top100Store = Top100Store()
    
    var body: some View {
        SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
            .tint(userStore.tint)
            .onChange(of: userStore.isFetching) { oldValue, newValue in
                if oldValue && !newValue {
                    updateSwiftData()
                }
            }
    }
    
    private func updateSwiftData() {
        if let userEntity = userStore.user {
            if let user = user {
                modelContext.delete(user)
            }
            
            let newUser = User(from: userEntity)
            newUser.totalUserCount = userStore.userCount
            
            if let profileEntity = userStore.profile {
                let newProfile = Profile(from: profileEntity)
                newUser.profile = newProfile
            }
            
            if let badgeEntity = userStore.badge {
                let newBadge = Badge(from: badgeEntity)
                newUser.badge = newBadge
            }
            
            modelContext.insert(newUser)
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}

#Preview {
    MainView()
        .modelContainer(previewContainer)
}
