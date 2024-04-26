//
//  MainTabView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var userStore = UserStore()
    @State private var problemsStore = ProblemsStore()
    @State private var top100Store = Top100Store()
    
    var body: some View {
        TabView {
            SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
                .tabItem {
                    Label("내 정보", systemImage: "list.clipboard")
                }
            AccountView()
                .tabItem {
                    Label("계정", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
