//
//  FontExtension.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

enum CustomFont: String {
    case bold = "SF-Pro-Rounded-Bold"
    case light = "SF-Pro-Rounded-Light"
    case medium = "SF-Pro-Rounded-Medium"
    case regular = "SF-Pro-Rounded-Regular"
    case thin = "SF-Pro-Rounded-Thin"
}
/// Расширение для Font
extension UIFont {
    /// Метод для создания шрифта с использованием CustomFont и заданного размера
    // label.font = .custom(font: .bold, size: 18)
    static func custom(font: CustomFont, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
