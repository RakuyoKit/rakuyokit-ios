//
//  ColorConfig.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024-2025 RakuyoKit. All rights reserved.
//

import UIKit

import RAKCore

// MARK: - ColorConfig

/// Color configuration
///
/// We recommend that when defining colors, you define `Tool` first,
/// and then reuse those same colors through `Tool`.
@dynamicMemberLookup
public struct ColorConfig {
    public typealias Color = UIColor

    /// From the perspective of color design specifications, the higher the level, the lighter the color should be.
    public class SecondLevel {
        public let main: Color

        public let secondary: Color

        public init(main: ConvertibleToColor, secondary: ConvertibleToColor) {
            self.main = main.color
            self.secondary = secondary.color
        }
    }

    /// From the perspective of color design specifications, the higher the level, the lighter the color should be.
    public class ThreeLevel: SecondLevel {
        public let tertiary: Color

        public init(main: ConvertibleToColor, secondary: ConvertibleToColor, tertiary: ConvertibleToColor) {
            self.tertiary = tertiary.color

            super.init(main: main, secondary: secondary)
        }
    }

    /// Tool color without usage scenarios or emotional overtones.
    public struct Tool {
        /// background gray
        public let backgroundGray: ThreeLevel

        /// auxiliary gray
        public let auxiliaryGray: ThreeLevel

        /// Please use this property instead of `UIColor.white` when using white in your project
        public let white: Color

        /// Please use this property instead of `UIColor.black` when using white in your project
        public let black: Color

        public init(
            backgroundGray: ThreeLevel,
            auxiliaryGray: ThreeLevel,
            white: ConvertibleToColor,
            black: ConvertibleToColor
        ) {
            self.backgroundGray = backgroundGray
            self.auxiliaryGray = auxiliaryGray
            self.white = white.color
            self.black = black.color
        }
    }

    /// Define different colors according to usage scenarios.
    public struct Semantic {
        /// Theme color
        ///
        /// Provides three levels of theme colors,
        /// you can use different levels of theme colors according to the situation.
        public let theme: ThreeLevel

        /// Text color
        public let text: ThreeLevel

        /// The color of the list dividing line.
        ///
        /// Generally refers to the color of the dividing line of UITableView,
        /// which means that it does not include the "separator bar".
        public let separator: Color

        /// Emphasis color.
        ///
        /// Provides three levels of choices for expressing *errors*, *warnings*, and *emphasis*.
        /// Recommendation: As the level increases, the degree should decrease: `main` represents `error`.
        public let emphasis: ThreeLevel

        /// Border color
        ///
        /// If you need transparency, you need to handle it yourself when defining the color value.
        public let border: Color

        /// Shadow color.
        ///
        /// If you need transparency, you need to handle it yourself when defining the color value.
        public let shadow: Color

        /// Text color when expressing "unavailable".
        ///
        /// Color commonly used when buttons are not clickable.
        public let unavailableText: Color

        public init(
            theme: ThreeLevel,
            text: ThreeLevel,
            separator: ConvertibleToColor,
            emphasis: ThreeLevel,
            border: ConvertibleToColor,
            shadow: ConvertibleToColor,
            unavailableText: ConvertibleToColor
        ) {
            self.theme = theme
            self.text = text
            self.separator = separator.color
            self.emphasis = emphasis
            self.border = border.color
            self.shadow = shadow.color
            self.unavailableText = unavailableText.color
        }
    }

    /// Tool color without usage scenarios or emotional overtones.
    public let tool: Tool

    /// Define different colors according to usage scenarios.
    public let semantic: Semantic

    public init(tool: Tool, semantic: Semantic) {
        self.tool = tool
        self.semantic = semantic
    }
}

// MARK: - Simplified calling

extension ColorConfig {
    public subscript<T>(dynamicMember keyPath: KeyPath<Tool, T>) -> T {
        tool[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Semantic, T>) -> T {
        semantic[keyPath: keyPath]
    }
}

// MARK: - Placeholder

extension ColorConfig {
    #if os(iOS) || os(visionOS)
    // swiftlint:disable:next closure_body_length
    public static let placeholder: Self = {
        let toolConfig = Tool(
            backgroundGray: .init(
                main: UIColor.systemGroupedBackground,
                secondary: UIColor.secondarySystemGroupedBackground,
                tertiary: UIColor.tertiarySystemGroupedBackground
            ),
            auxiliaryGray: .init(
                main: UIColor.systemGray4,
                secondary: UIColor.systemGray5,
                tertiary: UIColor.systemGray6
            ),
            white: UIColor.tertiarySystemBackground,
            black: UIColor.label
        )

        let semanticConfig = Semantic(
            theme: .init(
                main: UIColor.systemIndigo,
                secondary: UIColor.systemIndigo.withAlphaComponent(0.8),
                tertiary: UIColor.systemIndigo.withAlphaComponent(0.6)
            ),
            text: .init(
                main: UIColor.label,
                secondary: UIColor.secondaryLabel,
                tertiary: UIColor.tertiaryLabel
            ),
            separator: UIColor.separator,
            emphasis: .init(
                main: UIColor.systemRed,
                secondary: UIColor.systemOrange,
                tertiary: UIColor.systemPink
            ),
            border: toolConfig.auxiliaryGray.main,
            shadow: toolConfig.black.color.withAlphaComponent(0.2),
            unavailableText: UIColor.systemGray
        )

        return Self(tool: toolConfig, semantic: semanticConfig)
    }()

    #elseif os(tvOS)
    // swiftlint:disable:next closure_body_length
    public static let placeholder: Self = {
        let toolConfig = Tool(
            backgroundGray: .init(
                main: UIColor.white,
                secondary: UIColor.white,
                tertiary: UIColor.white
            ),
            auxiliaryGray: .init(
                main: UIColor.darkGray,
                secondary: UIColor.gray,
                tertiary: UIColor.lightGray
            ),
            white: UIColor.white,
            black: UIColor.black
        )

        let semanticConfig = Semantic(
            theme: .init(
                main: UIColor.blue,
                secondary: UIColor.blue.withAlphaComponent(0.8),
                tertiary: UIColor.blue.withAlphaComponent(0.6)
            ),
            text: .init(
                main: UIColor.black,
                secondary: UIColor.darkGray,
                tertiary: UIColor.gray
            ),
            separator: UIColor.lightGray,
            emphasis: .init(
                main: UIColor.red,
                secondary: UIColor.orange,
                tertiary: UIColor.yellow
            ),
            border: toolConfig.auxiliaryGray.main,
            shadow: toolConfig.black.color.withAlphaComponent(0.2),
            unavailableText: UIColor.darkGray
        )

        return Self(tool: toolConfig, semantic: semanticConfig)
    }()

    #elseif os(watchOS)
    // swiftlint:disable:next closure_body_length
    public static let placeholder: Self = {
        let toolConfig = Tool(
            backgroundGray: .init(
                main: UIColor.white,
                secondary: UIColor.white,
                tertiary: UIColor.white
            ),
            auxiliaryGray: .init(
                main: UIColor.darkGray,
                secondary: UIColor.gray,
                tertiary: UIColor.lightGray
            ),
            white: UIColor.white,
            black: UIColor.black
        )

        let semanticConfig = Semantic(
            theme: .init(
                main: UIColor.blue,
                secondary: UIColor.blue.withAlphaComponent(0.8),
                tertiary: UIColor.blue.withAlphaComponent(0.6)
            ),
            text: .init(
                main: UIColor.black,
                secondary: UIColor.darkGray,
                tertiary: UIColor.gray
            ),
            separator: UIColor.lightGray,
            emphasis: .init(
                main: UIColor.red,
                secondary: UIColor.orange,
                tertiary: UIColor.yellow
            ),
            border: toolConfig.auxiliaryGray.main,
            shadow: toolConfig.black.color.withAlphaComponent(0.2),
            unavailableText: UIColor.darkGray
        )

        return Self(tool: toolConfig, semantic: semanticConfig)
    }()
    #endif
}
