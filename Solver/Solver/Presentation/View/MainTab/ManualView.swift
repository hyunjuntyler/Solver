//
//  ManualView.swift
//  Solver
//
//  Created by hyunjun on 4/30/24.
//

import SwiftUI

struct ManualView: View {
    @AppStorage("manual") private var manual = true
    @State private var animate = [false, false, false, false, false]
    
    var body: some View {
        VStack {
            VStack {
                Image("Bulb")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64)
                    .shadow(color: .accentColor.opacity(0.8), radius: animate[2] ? 48 : 0)
                    .scaleEffect(animate[0] ? 1.05 : 1)
                    .padding(.bottom, 16)
                Text("Solver에 오신걸 환영해요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 32)
            }
            .opacity(animate[0] ? 1 : 0)
            .offset(y: animate[0] ? 0 : 8)
            
            ManualCell(emoji: "🧑🏻‍💻", title: "나의 백준 프로필을 확인해 보세요", subTitle: "나의 백준 프로필의 상세 정보를 확인할 수 있어요", animate: animate[1])
            
            ManualCell(emoji: "👆🏻", title: "많은 것들을 눌러보세요", subTitle: "각 요소들을 눌러 상세 정보를 확인해 보세요", animate: animate[2])
            
            ManualCell(emoji: "♻️", title: "실시간 정보를 확인해 보세요", subTitle: "아래로 드래그해 최신 정보를 업데이트해보세요", animate: animate[3])
            
            ManualCell(emoji: "📱", title: "위젯을 추가해 보세요", subTitle: "위젯을 통해 나의 백준 프로필을 확인해 보세요", animate: animate[4])
            
            Button("시작하기") {
                manual = false
            }
            .buttonStyle(CustomButtonStyle(style: .singUp))
            .opacity(animate[0] ? 1 : 0)
            .offset(y: animate[0] ? 0 : 8)
            .padding(.top, 48)
            .onAppear {
                for i in animate.indices {
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                        withAnimation(.easeInOut(duration: 1.2)) {
                            animate[i] = true
                        }
                    }
                }
            }
        }
    }
}

struct ManualCell: View {
    var emoji: String
    var title: String
    var subTitle: String
    var animate: Bool
    
    var body: some View {
        HStack {
            Text(emoji)
                .font(.tossLarge)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .fontWeight(.medium)
                Text(subTitle)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 8)
        .padding(.horizontal, 32)
        .padding(.vertical)
    }
}

#Preview {
    ManualView()
}
