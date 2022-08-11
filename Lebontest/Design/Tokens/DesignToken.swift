//
//  DesignToken.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

protocol DesignTokenType: AnyObject {
    var colorToken: ColorTokenType { get }
    var fontToken: FontTokenType { get }
}

final class DesignToken: DesignTokenType {

    static let shared = DesignToken()

    private var _colorToken: ColorTokenType = ColorToken()
    var colorToken: ColorTokenType {
        return _colorToken
    }

    private var _fontToken: FontTokenType = FontToken()
    var fontToken: FontTokenType {
        return _fontToken
    }
}
