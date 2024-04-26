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
    
    var tierName: String {
        self.tier + " " + self.romanNumeral
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
    
    var classBadgeColor: (in1: Color, in2: Color, out1: Color, out2: Color) {
        if self == 0 {
            return (Color(.systemGray6), Color(.systemGray5), Color(.systemGray4), Color(.systemGray3))
        }
        return (Color("Class\(self)In1"), Color("Class\(self)In2"), Color("Class\(self)Out1"), Color("Class\(self)Out2"))
    }
    
    func toPercentile(by: Int) -> Text {
        let percentile = Double(self) / Double(by)
        return Text(percentile, format: .number.rounded(increment: 0.01))
    }
    
    private var romanNumeral: String {
        var num = self
        let romanNumerals = [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        var result = ""
        for (value, numeral) in romanNumerals {
            while num >= value {
                result += numeral
                num -= value
            }
        }
        return result
    }
    
    private var tier: String {
        switch self {
        case 1...5: return "Bronze"
        case 6...10: return "Silver"
        case 11...15: return "Gold"
        case 16...20: return "Platinum"
        case 21...25: return "Diamond"
        case 26...30: return "Ruby"
        case 31...: return "Master"
        default: return "None"
        }
    }
}
