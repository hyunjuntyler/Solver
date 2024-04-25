//
//  MainTabView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var store = MainTabStore()
    
    var body: some View {
        TabView {
            SummaryView(store: store)
                .tabItem {
                    Label("내 정보", systemImage: "list.clipboard")
                }
            AccountView(store: store)
                .tabItem {
                    Label("계정", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
