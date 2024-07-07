//
//  SummaryView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
    @State private var frames: [CGRect] = []
    @State private var showInputSheet = false
    @ObservedObject var userStore: UserStore
    @ObservedObject var problemsStore: ProblemsStore
    @ObservedObject var top100Store: Top100Store
    @AppStorage("userId") private var userId = ""
    
    @Query private var users: [User]
    private var user: User? { users.first }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    if let user = user {
                        ProfileHeader(tier: user.tier, rating: user.rating, frames: frames)
                            .stickyHeader(frames, isMainHeader: true)
                    }
                    
                    Rectangle()
                        .frame(height: 30)
                        .foregroundStyle(.background)
                        .stickyHeader(frames, isEmptyHeader: true)
                        .padding(.bottom, -30)
                    
                    SummaryHeader(emoji: "🧑🏻‍💻", title: "요약")
                        .stickyHeader(frames)
                    
                    if let user = user {
                        Summary(rank: user.rank, rating: user.rating, tier: user.tier, solvedCount: user.solvedCount, maxStreak: user.maxStreak)
                            .summaryBody()
                    }
                    
                    SummaryHeader(emoji: "🚀", title: "내가 푼 상위 \(min(problemsStore.solvedCount, 100))문제")
                        .stickyHeader(frames)
                    
                    Top100Problems(store: top100Store)
                        .summaryBody()
                    
                    SummaryHeader(emoji: "📊", title: "내가 푼 문제 난이도 분포")
                        .stickyHeader(frames)
                    
                    ProblemsChart(store: problemsStore)
                        .summaryBody()
                    
                    Rectangle()
                        .frame(height: 40)
                        .foregroundStyle(.clear)
                        .stickyHeader(frames)
                }
            }
            .scrollIndicators(.hidden)
            .coordinateSpace(name: "container")
            .onPreferenceChange(StickyHeaderPreferenceKey.self) {
                frames = $0.sorted(by: { $0.minY < $1.minY })
            }
            .refreshable {
                userStore.fetch()
                top100Store.fetch()
                problemsStore.fetch()
            }
            .overlay(alignment: .top) {
                if let user = user {
                    user.tier.tierBackgroundColor
                        .ignoresSafeArea()
                        .frame(height: 0)
                }
            }
            .background(alignment: .top) {
                if let user = user, let first = frames.first {
                    user.tier.tierBackgroundColor
                        .frame(height: max(100 + first.minY, 100))
                }
            }
            .onChange(of: userId) {
                userStore.fetch()
                top100Store.fetch()
                problemsStore.fetch()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showInputSheet = false
                    Haptic.notification(type: .success)
                }
            }
            .sheet(isPresented: $showInputSheet) {
                NavigationStack {
                    SignUpView()
                        .toolbar {
                            Button {
                                showInputSheet = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .fontWeight(.bold)
                                    .foregroundStyle(Color(.systemGray4))
                            }
                        }
                }
                .presentationCornerRadius(24)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 4) {
                        if let user = user {
                            MainHeader(id: user.id, data: user.profile?.image)
                            
                            if let badge = user.badge {
                                BadgeImage(data: badge.image, size: 24)
                                    .onTapGesture {
                                        Haptic.impact(style: .soft)
                                        Toast.shared.present(data: badge.image, title: badge.name, body: badge.condition)
                                    }
                            }
                            
                            ZStack {
                                ClassWing(decoration: user.classDecoration, size: 24)
                                ClassBadge(userClass: user.userClass, size: 24)
                            }
                            .onTapGesture {
                                Haptic.impact(style: .soft)
                                Toast.shared.present(symbol: String(user.userClass), title: "Class \(user.userClass)", body: user.userClass.classToastSubTitle(user.classDecoration))
                            }
                        }
                    }
                }
                
                ToolbarItem {
                    Button {
                        showInputSheet = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(Color(.systemGray3))
                    }
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let userStore = UserStore(user: previewData.users[1], profile: previewData.profile, badge: previewData.badge)
    let problemsStore = ProblemsStore(problems: previewData.problems)
    let top100Store = Top100Store(top100: previewData.top100)
    return ToastWindow { SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store).modelContainer(previewContainer) }
}
