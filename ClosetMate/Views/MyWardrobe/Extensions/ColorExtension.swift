//
//  ColorExtension.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (Double((int >> 16) & 0xFF), Double((int >> 8) & 0xFF), Double(int & 0xFF))
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(
            .sRGB,
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            opacity: 1.0
        )
    }
}
