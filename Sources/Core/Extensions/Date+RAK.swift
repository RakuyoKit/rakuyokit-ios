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

    /// Timestamp for N days in the future
    public func apply(day: Int) -> Date? {
        calendar.date(byAdding: .day, value: day, to: base)
    }

    /// Timestamp for N years in the future
    public func apply(year: Int) -> Date? {
        calendar.date(byAdding: .year, value: year, to: base)
    }
}

// MARK: -

extension Extendable where Base == Date {
    public func format(with dateFormat: DateFormat) -> String {
        format(with: dateFormat.format)
    }

    public func format(with dateFormat: String) -> String {
        Self.serilizationQueue.sync {
            // It's considered that "Setting format is as expensive as recreating".
            // https://developer.apple.com/videos/play/wwdc2012/235/ (28:40)
            if Self.formatter.dateFormat != dateFormat {
                Self.formatter = DateFormatter()
                Self.formatter.dateFormat = dateFormat
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
}
