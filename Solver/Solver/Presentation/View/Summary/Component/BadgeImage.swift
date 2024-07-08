//
//  BadgeImage.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

struct BadgeImage: View {
    let data: Data?
    let size: CGFloat
    
    var body: some View {
        if let data = data, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: size)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    return BadgeImage(data: previewData.badge.image, size: 100)
}
