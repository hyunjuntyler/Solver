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
    let container: ModelContainer
    
    init() {
        let schema = Schema([User.self])
        let config = ModelConfiguration("Solver", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RootView {
                ContentView()
            }
            .modelContainer(container)
        }
    }
}
