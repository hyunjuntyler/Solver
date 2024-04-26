//
//  Int+Extension.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

extension Int {
    var tierBadgeNumber: String {
        if self == 31 { return "M" }
        let number = 6 - self % 5
        return number == 6 ? "1" : "\(number)"
    }
    
    var tierBadgeColor: LinearGradient {
        switch self {
        case 1...5: return LinearGradient(colors: [.bronze], startPoint: .bottom, endPoint: .top)
        case 6...10: return LinearGradient(colors: [.silver], startPoint: .bottom, endPoint: .top)
        case 11...15: return LinearGradient(colors: [.gold], startPoint: .bottom, endPoint: .top)
        case 16...20: return LinearGradient(colors: [.platinum], startPoint: .bottom, endPoint: .top)
        case 21...25: return LinearGradient(colors: [.diamond], startPoint: .bottom, endPoint: .top)
        case 26...30: return LinearGradient(colors: [.ruby], startPoint: .bottom, endPoint: .top)
        case 31...: return LinearGradient(colors: [.master1, .master2, .master3], startPoint: .bottom, endPoint: .top)
        default: return LinearGradient(colors: [.black], startPoint: .bottom, endPoint: .top)
        }
    }
}
