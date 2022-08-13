//
//  NumberFormatter.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

protocol NumberFormatterType {
    func format(value: Double, minDigits: Int, maxDigits: Int) -> String
}

final class NumberFormatter: NumberFormatterType {

    private let formatter = Foundation.NumberFormatter()

    private var locale: Locale {
        return Locale.current
    }

    func format(value: Double, minDigits: Int, maxDigits: Int) -> String {
        formatter.locale = locale
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = minDigits
        formatter.maximumFractionDigits = maxDigits
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}
