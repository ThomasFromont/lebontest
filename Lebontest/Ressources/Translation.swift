//
//  Translation.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

// MARK: - Translation

internal enum Translation {
    enum ClassifiedAds {
        static let navigationTitle = Translation.tr("Localizable", "classified_ads.navigation_title")
    }
}

// MARK: - Implementation Details

extension Translation {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        return Bundle(for: BundleToken.self)
    }()
}
