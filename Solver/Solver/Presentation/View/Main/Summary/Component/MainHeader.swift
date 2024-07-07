//
//  MainHeader.swift
//  Solver
//
//  Created by hyunjun on 7/7/24.
//

import SwiftUI

struct MainHeader: View {
    let id: String
    let data: Data?
    
    private let size: CGFloat = 26
    
    var body: some View {
        HStack {
            if let data = data, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size)
                    .clipShape(RoundedRectangle(cornerRadius: size/4, style: .continuous))
                    .shadow(radius: 2)
            } else {
                Image("Profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.85)
                    .clipShape(RoundedRectangle(cornerRadius: size/4, style: .continuous))
                    .background {
                        RoundedRectangle(cornerRadius: size/4, style: .continuous)
                            .frame(width: size, height: size)
                            .foregroundStyle(Color(.systemGray5))
                            .shadow(radius: 2)
                    }
            }
            
            Text(id)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    NavigationStack {
        Text("Preview")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    MainHeader(id: "useruseruseruseruser", data: nil)
                }
            }
    }
}
