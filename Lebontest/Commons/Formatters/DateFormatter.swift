//
//  DateFormatter.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import Foundation

protocol DateFormatterType {
    func formatDayRelative(date: Date, relativeTo: Date) -> String
}

final class DateFormatter: DateFormatterType {

    private var formattersCachedByDateFormat: [String: Foundation.DateFormatter] = [:]
    private let queue = DispatchQueue(label: "lebontest.dateformatter", qos: DispatchQoS.userInteractive)

    private let calendar: Calendar = .current
    private var locale: Locale {
        return Locale.current
    }

    // MARK: - DateFormatterType

    func formatDayRelative(date: Date, relativeTo referenceDate: Date) -> String {
        switch numberOfDays(from: referenceDate, to: date, in: calendar) {
        case -1:
            return dateFormatter(for: .yesterdayWithTime).string(from: date)
        case 0:
            return dateFormatter(for: .todayWithTime).string(from: date)
        default:
            return dateFormatter(for: .dayWithTime).string(from: date)
        }
    }

    // MARK: - Private

    private func numberOfDays(from date1: Date, to date2: Date, in calendar: Calendar) -> Int {
        let startOfDayInDate1 = calendar.startOfDay(for: date1)
        let startOfDayInDate2 = calendar.startOfDay(for: date2)
        let components = calendar.dateComponents([.day], from: startOfDayInDate1, to: startOfDayInDate2)

        return components.day ?? 0
    }

    private func dateFormatter(for dateFormat: DateFormat) -> Foundation.DateFormatter {
        let dateFormatString = dateFormat.translation

        var formatter: Foundation.DateFormatter?
        queue.sync {
            if let cachedFormatter = formattersCachedByDateFormat[dateFormatString] {
                formatter = cachedFormatter
            } else {
                formatter = Foundation.DateFormatter()
                formatter?.locale = locale
                formatter?.dateFormat = dateFormatString
                formattersCachedByDateFormat[dateFormatString] = formatter
            }
        }

        return formatter ?? .init()
    }
}

private enum DateFormat {
    case dayWithTime
    case yesterdayWithTime
    case todayWithTime

    var translation: String {
        switch self {
        case .dayWithTime: return Translation.DateFormatter.dayWithTime
        case .yesterdayWithTime: return Translation.DateFormatter.yesterdayWithTime
        case .todayWithTime: return Translation.DateFormatter.todayWithTime
        }
    }
}
