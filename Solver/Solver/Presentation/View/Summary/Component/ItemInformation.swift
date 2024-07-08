//
//  ProblemInformation.swift
//  Solver
//
//  Created by hyunjun on 7/8/24.
//

import SwiftUI

struct ItemInformation: View {
    @State private var showWebView = false
    let urlString = "https://www.acmicpc.net/problem/"
    let item: ItemEntity
    let action: () -> Void
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TierBadge(tier: item.level, size: 20)
                        .offset(y: 1)
                    Text(String(item.id))
                        .font(.headline)
                        .fontWeight(.semibold)
                        .fontDesign(.monospaced)
                        .contentTransition(.numericText())
                }
                Text("\(item.title)")
                    .bold()
                    .font(.title3)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("알고리즘 분류")
                    .fontWeight(.semibold)
                    .font(.callout)
                    ForEach(item.tags, id: \.key) { tag in
                        let displayNames = tag.displayNames.filter { $0.language == "ko" }.map { $0.short }.joined()
                        
                        Text("\(displayNames)")
                            .font(.footnote)
                    }
            }
            .padding(8)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundStyle(Color(.systemGray2))
                    .opacity(0.3)
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 16)
        .overlay(alignment: .topTrailing) {
            CloseButton {
                action()
            }
            .padding(8)
        }
        .background {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .transition(.opacity)
        .sheet(isPresented: $showWebView) {
            NavigationStack {
                WebView(url: urlString + "\(item.id)")
                    .ignoresSafeArea()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            HStack {
                                TierBadge(tier: item.level, size: 18)
                                    .offset(y: 1)
                                Text(String(item.id))
                                    .fontWeight(.semibold)
                                    .fontDesign(.monospaced)
                                    .contentTransition(.numericText())
                                Text("\(item.title)")
                            }
                            .foregroundStyle(item.level.tierColor)
                        }
                        ToolbarItem {
                            CloseButton {
                                showWebView = false
                            }
                        }
                    }
            }
            .presentationCornerRadius(24)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let items = previewData.items
    return ItemInformation(item: items[0]) { }
}
