//
//  ThemeManager.swift
//  FluxStore
//
//  Created by Berker Saptas on 19.09.2023.
//

import Foundation
import SwiftUI


struct ThemeManager {
    @Environment(\.colorScheme) var colorScheme

    func isDarkMode() -> Bool {
        return colorScheme == .dark
    }
}
