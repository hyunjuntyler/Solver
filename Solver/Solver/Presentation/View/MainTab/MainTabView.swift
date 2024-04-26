//
//  MainTabView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SummaryView()
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
