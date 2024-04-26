//
//  ProfileImage.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

struct ProfileImage: View {
    var data: Data?
    var size: CGFloat
    
    var body: some View {
        if let data = data, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: size)
                .clipShape(RoundedRectangle(cornerRadius: size/4, style: .continuous))
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: size/4, style: .continuous)
                    .frame(width: size, height: size)
                    .foregroundStyle(Color(.systemGray5))
                Image("Profile")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.85)
                    .clipShape(RoundedRectangle(cornerRadius: size/4, style: .continuous))
            }
        }
    }
}

#Preview {
    let previewData = PreviewData()
    return ProfileImage(data: previewData.profile.image, size: 80)
}

#Preview {
    return ProfileImage(size: 80)
}
