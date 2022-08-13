//
//  ColorToken.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit

protocol ColorTokenType: AnyObject {
    var background: UIColor { get }
    var divider: UIColor { get }

    var textPrimary: UIColor { get }
    var textHighlighted: UIColor { get }
    var backgroundHighlighted: UIColor { get }
}

class ColorToken: ColorTokenType {

    private enum ColorPalette {
        static let black: UInt32 = 0x000000
        static let grey: UInt32 = 0x8191A0
        static let orangeLight: UInt32 = 0xFEF0E9
        static let orangeDark: UInt32 = 0xFF6E14
        static let white: UInt32 = 0xFFFFFF
    }

    // MARK: - ColorSchemeType

    var background: UIColor {
        return ColorToken.color(lightHex: ColorPalette.white, darkHex: ColorPalette.black)
    }
    var divider: UIColor {
        return ColorToken.color(lightHex: ColorPalette.grey, darkHex: ColorPalette.grey)
    }

    var textPrimary: UIColor {
        return ColorToken.color(lightHex: ColorPalette.black, darkHex: ColorPalette.white)
    }
    var textHighlighted: UIColor {
        return ColorToken.color(lightHex: ColorPalette.orangeDark, darkHex: ColorPalette.orangeLight)
    }
    var backgroundHighlighted: UIColor {
        return ColorToken.color(lightHex: ColorPalette.orangeLight, darkHex: ColorPalette.orangeDark)
    }
}

private extension ColorToken {
    static func color(lightHex: UInt32, darkHex: UInt32) -> UIColor {
        if #available(iOS 12, *) {
            return UIColor { (traitCollection: UITraitCollection) -> UIColor in
                let darkColor = UIColor(hex: darkHex)
                let lightColor = UIColor(hex: lightHex)
                return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
            }
        } else {
            return UIColor(hex: lightHex)
        }
    }
}

private extension UIColor {
    convenience init(hex: UInt32) {
        let divisor = CGFloat(255)
        let red = CGFloat((hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat((hex & 0x00FF00) >> 8) / divisor
        let blue = CGFloat(hex & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
