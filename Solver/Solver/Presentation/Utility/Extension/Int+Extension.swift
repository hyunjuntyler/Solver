//
//  Int+Extension.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

extension Int {
    var tier: String {
        switch self {
        case 1...5: return "Bronze"
        case 6...10: return "Silver"
        case 11...15: return "Gold"
        case 16...20: return "Platinum"
        case 21...25: return "Diamond"
        case 26...30: return "Ruby"
        case 31...: return "Master"
        default: return "Unrated"
        }
    }
    
    var tierNumber: String {
        if self == 31 { return "M" }
        if self == 0 { return "?" }
        let number = 5 - (self - 1) % 5
        return "\(number)"
    }
    
    var tierColor: Color {
        switch self {
        case 1...5: return .bronze
        case 6...10: return .silver
        case 11...15: return .gold
        case 16...20: return .platinum
        case 21...25: return .diamond
        case 26...30: return .ruby
        default: return .master2
        }
    }
    
    var tierBackgroundColor: Color {
        switch self {
        case 1...5: return .bronzeBackground
        case 6...10: return .silverBackground
        case 11...15: return .goldBackground
        case 16...20: return .platinumBackground
        case 21...25: return .diamondBackground
        case 26...30: return .rubyBackground
        default: return .masterBackground
        }
    }
    
    var tierName: String {
        if self == 31 { return self.tier }
        return self.tier + " " + self.romanNumeral
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
        default: return LinearGradient(colors: [.unrated], startPoint: .bottom, endPoint: .top)
        }
    }
    
    var classBadgeColor: (in1: Color, in2: Color, out1: Color, out2: Color) {
        if self == 0 {
            return (Color(.systemGray6), Color(.systemGray5), Color(.systemGray4), Color(.systemGray3))
        }
        return (Color("Class\(self)In1"), Color("Class\(self)In2"), Color("Class\(self)Out1"), Color("Class\(self)Out2"))
    }
    
    func classToastSubTitle(_ decoration: String) -> String {
        switch decoration {
        case "silver": 
            switch self {
            case 1:
                return "해당 클래스 에센셜 16문제 해결"
            case 2, 3:
                return "해당 클래스 에센셜 20문제 해결"
            default:
                return "해당 클래스 에센셜 24문제 해결"
            }
        case "gold":
            return "해당 전체 문제 해결"
        default: 
            switch self {
            case 0:
                return "문제를 풀어 Class를 획득해 보세요"
            case 1, 2:
                return "해당 클래스 16문제 해결"
            default: 
                return "해당 클래스 20문제 해결"
            }
        }
    }
    
    func toPercentile(by: Int) -> Text {
        let percentile = Double(self) / Double(by) * 100
        return Text(percentile, format: .number.rounded(rule: .up, increment: 0.1))
    }
    
    private var romanNumeral: String {
        var num = 5 - (self - 1) % 5
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
}
