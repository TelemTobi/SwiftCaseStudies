//
//  ThemeColorEnvironment.swift
//  SwiftCaseStudies
//
//  Created by Telem Tobi on 07/02/2024.
//

import SwiftUI

private struct ThemeColorEnvironment: EnvironmentKey {
    static let defaultValue: Color = .accentColor
}

extension EnvironmentValues {
    
    var themeColor: Color {
        get { self[ThemeColorEnvironment.self] }
        set { self[ThemeColorEnvironment.self] = newValue }
    }
}
