//
//  StickyHeaderPreferenceKey.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/27/24.
//

import SwiftUI

struct StickyHeaderPreferenceKey: PreferenceKey {
    static var defaultValue: [CGRect] = []
    
    static func reduce(value: inout [CGRect], nextValue: () -> [CGRect]) {
        value.append(contentsOf: nextValue())
    }
}
