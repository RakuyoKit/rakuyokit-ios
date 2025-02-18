//
//  Date+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 RakuyoKit. All rights reserved.
//

import Foundation

extension Date {
    public var unixTimestamp: Int64 { Int64(timeIntervalSince1970) }

    public var javaTimestamp: Int64 { unixTimestamp * 1000 }

    public init(unixTimestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(unixTimestamp))
    }

    public init(javaTimestamp: Int64) {
        self.init(timeIntervalSince1970: TimeInterval(javaTimestamp) / 1000)
    }
}

// MARK: - Information of date

extension Extendable where Base == Date {
    /// The year corresponding to this date
    public var year: Int { dateComponents(.year).year ?? 0 }

    /// The month corresponding to this date
    public var month: Int { dateComponents(.month).month ?? 0 }

    /// The day corresponding to this date
    public var day: Int { dateComponents(.day).day ?? 0 }

    /// The weekday corresponding to this date
    public var weekday: Int { dateComponents(.weekday).weekday ?? 0 }

    /// The hour corresponding to this date
    public var hour: Int { dateComponents(.hour).hour ?? 0 }

    /// The minute corresponding to this date
    public var minute: Int { dateComponents(.minute).minute ?? 0 }

    /// The second corresponding to this date
    public var second: Int { dateComponents(.second).second ?? 0 }

    /// Whether this date is yesterday
    public var isYesterday: Bool { calendar.isDateInYesterday(base) }

    /// Whether this date is today
    public var isToday: Bool { calendar.isDateInToday(base) }

    /// Whether this date is tomorrow
    public var isTomorrow: Bool { calendar.isDateInTomorrow(base) }
    
    /// Determine whether two dates are the same day
    public func isSameDay(to otherDay: Date) -> Bool {
        calendar.isDate(base, inSameDayAs: otherDay)
    }
}

// MARK: - Time manipulation

extension Extendable where Base == Date {
    /// One second
    public static var second: TimeInterval { 1 }

    /// Number of seconds in one minute
    public static var minute: TimeInterval { second * 60 }

    /// Number of seconds in one hour
    public static var hour: TimeInterval { minute * 60 }

    /// Number of seconds in one day
    public static var day: TimeInterval { hour * 24 }

    /// Start time of the current date
    public static var start: Date { Calendar.current.startOfDay(for: .init()) }

    /// Start time of the specified date
    public var start: Date { calendar.startOfDay(for: base) }

    /// Increment or decrement `value` on `component` based on the current time.
    ///
    /// A positive value represents the future, and a negative value represents the past.
    public func apply(value: Int, by component: Calendar.Component) -> Date? {
        calendar.date(byAdding: component, value: value, to: base)
    }

    /// Increment or decrement `value` on `.second` based on the current time.
    ///
    /// A positive value represents the future, and a negative value represents the past.
    public func apply(second value: Int) -> Date? {
        apply(value: value, by: .second)
    }

    /// Increment or decrement `value` on `.day` based on the current time.
    ///
    /// A positive value represents the future, and a negative value represents the past.
    public func apply(day value: Int) -> Date? {
        apply(value: value, by: .day)
    }
    
    /// Increment or decrement `value` on `.year` based on the current time.
    ///
    /// A positive value represents the future, and a negative value represents the past.
    public func apply(year value: Int) -> Date? {
        apply(value: value, by: .year)
    }
}

// MARK: -

extension Extendable where Base == Date {
    public func format(with dateFormat: DateFormat) -> String {
        format(with: dateFormat.format)
    }

    public func format(with dateFormat: String, timeZone: TimeZone? = nil) -> String {
        Self.serilizationQueue.sync {
            // It's considered that "Setting format is as expensive as recreating".
            // https://developer.apple.com/videos/play/wwdc2012/235/ (28:40)
            if Self.formatter.dateFormat != dateFormat {
                Self.formatter = DateFormatter()
                Self.formatter.dateFormat = dateFormat
                
                if let timeZone {
                    Self.formatter.timeZone = timeZone
                }
            }

            return Self.formatter.string(from: base)
        }
    }
}

// MARK: - Tools

extension Extendable where Base == Date {
    private static var formatter = DateFormatter()
    private static let serilizationQueue = DispatchQueue(label: "com.rakuyo.rakuyo-kit.date-formatter")

    private var calendar: Calendar { .current }
    
    private func dateComponents(_ components: Calendar.Component ...) -> DateComponents {
        calendar.dateComponents(.init(components), from: base)
    }
}
