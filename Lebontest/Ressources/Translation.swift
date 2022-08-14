//
//  Translation.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

// MARK: - Translation

internal enum Translation {

    enum DateFormatter {
        static let dayWithTime = Translation.tr("Localizable", "date_formatter.dayWithTime")
        static let todayWithTime = Translation.tr("Localizable", "date_formatter.todayWithTime")
        static let yesterdayWithTime = Translation.tr("Localizable", "date_formatter.yesterdayWithTime")
    }

    enum ClassifiedAds {
        static let navigationTitle = Translation.tr("Localizable", "classified_ads.navigation_title")

        enum Error {
            static let title = Translation.tr("Localizable", "classified_ads.error.title")
            static let button = Translation.tr("Localizable", "classified_ads.error.button")
        }

        enum Cell {
            static let urgent = Translation.tr("Localizable", "classified_ads.cell.urgent")
        }
    }

    enum ClassifiedAdDetails {
        static let navigationTitle = Translation.tr("Localizable", "classified_ad_details.navigation_title")
        static let urgent = Translation.tr("Localizable", "classified_ad_details.urgent")
        static let description = Translation.tr("Localizable", "classified_ad_details.description")

        static func siret(_ arg: String) -> String {
          return Translation.tr("Localizable", "classified_ad_details.siret", arg)
        }
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
