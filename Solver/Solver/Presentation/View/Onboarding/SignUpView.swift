//
//  SignUpView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct SignUpView: View {
    @AppStorage("userId") private var userId = ""
    @State private var store = SignUpStore()
    
    private var disable: Bool {
        !store.isValid || store.userId == "" || userId == store.userId
    }
    
    var body: some View {
        VStack {
            Text("👩‍💻🧑‍💻")
                .font(.tossLarge)
                .padding(.bottom)
            Text("백준 아이디를 입력해주세요")
            
            TextField("", text: $store.userId)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundStyle(.bar)
                }
                .padding(.horizontal)
                .onChange(of: store.userId) {
                    store.validateUserId()
                }
            ZStack {
                Text("아이디는 알파벳, 숫자와 밑줄(_)만 가능해요")
                    .foregroundStyle(.red)
                    .opacity(!store.isValid ? 1 : 0)
                    .animation(.bouncy, value: store.isValid)
                Text("동일한 아이디예요")
                    .foregroundStyle(.blue)
                    .opacity(store.userId != "" && userId == store.userId ? 1 : 0)
                    .animation(.bouncy, value: userId == store.userId)
            }
            .font(.footnote)
            .padding(.bottom)
            
            Button("확인") {
                store.checkUserId()
            }
            .buttonStyle(CustomButtonStyle(style: .singUp, disable: disable))
            .disabled(disable)
            .padding(.bottom, 56)
            
            VStack(spacing: 8) {
                Image(systemName: "network")
                    .font(.title3)
                    .foregroundStyle(.gray)
                Text("이 앱은 Solved.ac 에서 API를 제공받아 만든 앱이예요. Solved.ac에 등록된 아이디만 등록이 가능해요.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .padding(.horizontal, 24)
            }
        }
        .alert("아이디를 확인해주세요", isPresented: $store.showAlert) {
            Button("돌아가기") {
                store.userId = ""
            }
        } message: {
            Text("Solved.ac에 등록되어 있지 않거나 유효하지 않는 아이디예요")
        }
    }
}

#Preview {
    SignUpView()
}
