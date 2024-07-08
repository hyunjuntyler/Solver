//
//  ChangeIdSheet.swift
//  Solver
//
//  Created by hyunjun on 7/8/24.
//

import SwiftUI

struct ChangeIdSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            SignUpView()
                .toolbar {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .fontWeight(.bold)
                            .foregroundStyle(Color(.systemGray4))
                    }
                }
        }
        .presentationCornerRadius(24)
    }
}

#Preview {
    ChangeIdSheet()
}
