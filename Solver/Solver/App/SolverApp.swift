//
//  SolverApp.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI
import SwiftData

@main
struct SolverApp: App {
    var body: some Scene {
        WindowGroup {
            ToastWindow {
                ContentView()
            }
            .modelContainer(for: [User.self])
        }
    }
}
