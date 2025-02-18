//
//  DateFormat.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/5/21.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import Foundation

// MARK: - FormattableDateUnit

public protocol FormattableDateUnit {
    associatedtype FormatType: RawRepresentable<String>

    typealias Separator = RAKCore.DateFormat.Separator

    var types: [FormatType] { get }

    var separator: Separator? { get }
}

extension FormattableDateUnit {
    var format: String {
        types.map(\.rawValue).joined(separator: separator?.rawValue ?? "")
    }
}

// MARK: - DateFormat

/// ISO8601 date format.
public struct DateFormat: Equatable {
    public enum Separator: String, Equatable {
        /// `_`
        case underscores = "_"

        /// `-`
        case shortDashes = "-"

        /// `:`
        case colons = ":"

        /// `/`
        case slash = "/"

        /// `.`
        case dots = "."
    }

    public struct Date: Equatable, FormattableDateUnit {
        public enum FormatType: String, Equatable {
            /// `yyyy`
            case year = "yyyy"

            /// `MM`
            case month = "MM"

            /// `dd`
            case day = "dd"
        }

        public let types: [FormatType]

        public let separator: Separator?

        public init(_ types: [FormatType] = .all, separator: Separator?) {
            self.types = types
            self.separator = separator
        }
    }

    public struct Time: Equatable, FormattableDateUnit {
        public enum FormatType: String, Equatable {
            /// `HH`
            case hour = "HH"

            /// `mm`
            case minute = "mm"

            /// `ss`
            case second = "ss"
        }

        public let types: [FormatType]

        public let separator: Separator?

        public init(_ types: [FormatType] = .all, separator: Separator? = .colons) {
            self.types = types
            self.separator = separator
        }
    }

    ///
    public let format: String

    public init(date: Date? = nil, time: Time? = nil, separator: Separator? = nil) {
        switch (date, time) {
        case (.some(let value), nil):
            format = value.format

        case (nil, .some(let value)):
            format = value.format

        case (.some(let dateValue), .some(let timeValue)):
            format = dateValue.format + (separator?.rawValue ?? " ") + timeValue.format

        case (nil, nil):
            format = ""
        }
    }
}

// MARK: -

extension DateFormat {
    /// `yyyy.MM.dd`
    public static var yDotD: Self {
        .init(date: .init(separator: .dots))
    }

    /// `yyyy.MM.dd HH:mm`
    public static var yDotD_h_m: Self {
        .init(
            date: .init(separator: .dots),
            time: .init([.hour, .minute])
        )
    }

    /// `yyyy-MM-dd`
    public static var y_d: Self {
        .init(date: .init(separator: .shortDashes))
    }

    /// `yyyy-MM-dd HH:mm`
    public static var y_d_h_m: Self {
        .init(
            date: .init(separator: .shortDashes),
            time: .init([.hour, .minute])
        )
    }

    /// `yyyy-MM-dd HH:mm:ss`
    public static var y_d_h_s: Self {
        .init(
            date: .init(separator: .shortDashes),
            time: .init()
        )
    }

    /// `HH:mm`
    public static var h_m: Self {
        .init(time: .init([.hour, .minute]))
    }

    /// `yyyy_MM_dd_HH_mm_ss`
    public static var fullTimeForFileName: Self {
        .init(
            date: .init(separator: .underscores),
            time: .init(separator: .underscores),
            separator: .underscores
        )
    }
}

// MARK: -

extension [DateFormat.Date.FormatType] {
    public static var all: Self { [.year, .month, .day] }
}

extension [DateFormat.Time.FormatType] {
    public static var all: Self { [.hour, .minute, .second] }
}
