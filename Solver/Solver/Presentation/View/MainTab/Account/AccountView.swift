//
//  AccountView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct AccountView: View {
    var userStore: UserStore
    var problemsStore: ProblemsStore
    var top100Store: Top100Store
    
    @AppStorage("userId") private var userId = ""
    @State private var showInputSheet = false
    @State private var isLoading = false
    
    var body: some View {
        if let user = userStore.user {
            VStack {
                VStack {
                    ProfileImage(data: userStore.profile?.image, size: 120)
                        .padding(.bottom, 8)
                    Text(user.id)
                        .font(.title2)
                }
                .padding(.top, 40)
                .padding(.bottom, 24)
                
                
                Button("아이디 바꾸기") {
                    showInputSheet = true
                }
                .buttonStyle(CustomButtonStyle(style: .changeId))
            }
            .frame(maxHeight: .infinity, alignment: .top)
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
                            .disabled(isLoading)
                        }
                        .overlay {
                            if isLoading {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .frame(width: 120, height: 120)
                                    .foregroundStyle(.ultraThinMaterial)
                                ProgressView()
                                    .controlSize(.large)
                            }
                        }
                }
            }
            .onChange(of: userId) {
                isLoading = true
                userStore.fetch()
                top100Store.fetch()
                problemsStore.fetch()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    showInputSheet = false
                    isLoading = false
                }
            }
            .overlay(alignment: .top) {
                Color(user.tier.tierBackgroundColor)
                    .ignoresSafeArea()
                    .frame(height: 0)
            }
            .background(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.systemBackground), Color(.systemBackground), Color(.systemBackground)], startPoint: .top, endPoint: .bottom))
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let userStore = UserStore(user: previewData.users[0], profile: previewData.profile, badge: previewData.badge)
    let problemsStore = ProblemsStore(problems: previewData.problems)
    let top100Store = Top100Store(top100: previewData.top100)
    return AccountView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
}
