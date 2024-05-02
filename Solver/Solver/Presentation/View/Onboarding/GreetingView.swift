//
//  GreetingView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct GreetingView: View {
    @State private var animate = false
    
    var body: some View {
        VStack {
            Text("🎉")
                .font(.tossLarge)
                .scaleEffect(animate ? 1.2 : 1)
                .padding(.bottom)
            Text("프로그래머님 반가워요!")
                .font(.title2)
                .fontWeight(.medium)
        }
        .padding(.bottom, 32)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 8)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.8)) {
                animate = true
            }
        }
    }
}

#Preview {
    GreetingView()
}
