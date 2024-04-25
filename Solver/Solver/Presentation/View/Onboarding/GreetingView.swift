//
//  GreetingView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct GreetingView: View {
    var body: some View {
        VStack {
            Text("🎉")
                .font(.tossLarge)
                .padding(.bottom)
            Text("프로그래머님 반가워요")
        }
    }
}

#Preview {
    GreetingView()
}
