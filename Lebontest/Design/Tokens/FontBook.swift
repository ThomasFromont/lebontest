//
//  FontToken.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit
import Foundation

protocol FontTokenType: AnyObject {
    var title: UIFont { get }
    var subtitle: UIFont { get }
    var info: UIFont { get }
}

class FontToken: FontTokenType {

    var title: UIFont { return font(of: 16, with: UIFont.Weight.semibold) }
    var subtitle: UIFont { return font(of: 12, with: UIFont.Weight.regular) }
    var info: UIFont { return font(of: 12, with: UIFont.Weight.light) }

    // MARK: - Private

    private func font(of size: CGFloat, with weight: UIFont.Weight) -> UIFont {
        let openSansFont = OpenSansFont.of(weight: weight)
        if !UIFont.fontNames(forFamilyName: Constant.fontFamilyName).contains(openSansFont.rawValue) {
            register(font: openSansFont)
        }

        return UIFont(name: openSansFont.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }

    // MARK: - Private

    private func register(font: OpenSansFont) {
        let bundle = Bundle(for: FontToken.self)

        let fontURL = bundle.url(forResource: font.rawValue, withExtension: Constant.fontExtension)
        let cgDataProvider = fontURL.flatMap { CGDataProvider(url: $0 as CFURL) }
        if let cgFont = cgDataProvider.flatMap({ CGFont($0) }) {
            CTFontManagerRegisterGraphicsFont(cgFont, nil)
        }
    }

    private enum Constant {
        static let fontFamilyName = "OpenSans"
        static let fontExtension = "ttf"
    }

    private enum OpenSansFont: String {
        case light = "OpenSans-Light"
        case regular = "OpenSans-Regular"
        case semibold = "OpenSans-Semibold"

        static func of(weight: UIFont.Weight) -> OpenSansFont {
            switch weight {
            case UIFont.Weight.light:
                return OpenSansFont.light
            case UIFont.Weight.regular:
                return OpenSansFont.regular
            case UIFont.Weight.semibold:
                return OpenSansFont.semibold
            default:
                return OpenSansFont.regular
            }
        }
    }
}
