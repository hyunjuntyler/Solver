//
//  Toast.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct RootView<Content: View>: View {
    @ViewBuilder var content: Content
    @State private var overlayWindow: UIWindow?
    
    var body: some View {
        content
            .onAppear {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
                    let window = PassthroughWindow(windowScene: windowScene)
                    window.backgroundColor = .clear
                    
                    let rootViewController = UIHostingController(rootView: ToastGroup())
                    rootViewController.view.frame = windowScene.keyWindow?.frame ?? .zero
                    rootViewController.view.backgroundColor = .clear
                    
                    window.rootViewController = rootViewController
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    // tag value to extract the overlay window from the window scene
                    window.tag = 1009
                    
                    overlayWindow = window
                }
            }
    }
}

fileprivate class PassthroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let view = super.hitTest(point, with: event) else { return nil }
        return rootViewController?.view == view ? nil : view
    }
}

@Observable
class Toast {
    static let shared = Toast()
    fileprivate var toasts: [ToastItem] = []
    
    func present(title: String, symbol: String?, tint: Color = .primary, enabled: Bool = false, time: ToastTime = .medium) {
        withAnimation(.snappy) {
            toasts.append(ToastItem(title: title, symbol: symbol, tint: tint, enabled: enabled, time: time))
        }
    }
}

struct ToastItem: Identifiable {
    let id = UUID()
    var title: String
    var symbol: String?
    var tint: Color
    var enabled: Bool
    var time: ToastTime = .medium
}

enum ToastTime: CGFloat {
    case short = 1.0
    case medium = 2.0
    case long = 3.5
}

fileprivate struct ToastGroup: View {
    var model = Toast.shared
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                ForEach(model.toasts) { toast in
                    ToastView(size: size, item: toast)
                        .scaleEffect(scale(toast))
                        .offset(y: offset(toast))
                        .zIndex(Double(model.toasts.firstIndex(where: { $0.id == toast.id }) ?? 0))
                }
            }
            .padding(.top, safeArea.top == .zero ? 15 : 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    private func offset(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let total = CGFloat(model.toasts.count) - 1
        return total - index >= 2 ? -10 : (total - index) * -5
    }
    
    private func scale(_ item: ToastItem) -> CGFloat {
        let index = CGFloat(model.toasts.firstIndex(where: { $0.id == item.id }) ?? 0)
        let total = CGFloat(model.toasts.count) - 1
        return 1.0 - (total - index >= 2 ? 0.2 : (total - index) * 0.1)
    }
}

fileprivate struct ToastView: View {
    var size: CGSize
    var item: ToastItem
    
    @State private var delayTask: DispatchWorkItem?
    var body: some View {
        HStack(spacing: 0) {
            if let symbol = item.symbol {
                Text(symbol)
                    .font(.tossBody)
                    .padding(.trailing, 10)
            }
            
            Text(item.title)
        }
        .foregroundStyle(item.tint)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            .background
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: 5, y: 5))
                .shadow(.drop(color: .primary.opacity(0.06), radius: 5, x: -5, y: -5)),
            in: .capsule
        )
        .contentShape(.capsule)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onEnded { value in
                    guard item.enabled else { return }
                    let endY = value.translation.height
                    let velocityY = value.velocity.height
                    
                    if endY + velocityY < 100 {
                        removeToast()
                    }
                }
        )
        .onAppear {
            guard delayTask == nil else { return }
            delayTask = DispatchWorkItem(block: removeToast)
            
            if let delayTask {
                DispatchQueue.main.asyncAfter(deadline: .now() + item.time.rawValue, execute: delayTask)
            }
        }
        .frame(maxWidth: size.width * 0.7)
        .transition(.offset(y: -150))
    }
    
    private func removeToast() {
        if let delayTask {
            delayTask.cancel()
        }

        withAnimation(.snappy) {
            Toast.shared.toasts.removeAll(where: { $0.id == item.id })
        }
    }
}

struct ToastTestView: View {
    var body: some View {
        VStack {
            Button("Toast Animation") {
                Toast.shared.present(
                    title: "hello",
                    symbol: "🤩",
                    enabled: true
                )
            }
        }
    }
}

#Preview {
    RootView {
        ToastTestView()
    }
}
