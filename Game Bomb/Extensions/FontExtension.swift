//
//  FontExtension.swift
//  Game Bomb
//
//  Created by Alexander Bokhulenkov on 09.02.2025.
//

import UIKit

enum CustomFont: String {
    case bold = "SFProRounded-Bold"
    case light = "SFProRounded-Light"
    case medium = "SFProRounded-Medium"
    case regular = "SFProRounded-Regular"
    case thin = "SFProRounded-Thin"
}
/// Расширение для Font
extension UIFont {
    /// Метод для создания шрифта с использованием CustomFont и заданного размера
    // label.font = .custom(font: .bold, size: 18)
    static func custom(font: CustomFont, size: CGFloat) -> UIFont {
        UIFont(name: font.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
