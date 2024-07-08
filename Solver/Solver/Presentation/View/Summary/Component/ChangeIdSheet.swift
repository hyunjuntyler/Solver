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
                    CloseButton {
                        dismiss()
                    }
                }
        }
        .presentationCornerRadius(24)
    }
}

#Preview {
    ChangeIdSheet()
}
