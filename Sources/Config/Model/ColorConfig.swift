//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
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
        
        public init(main: Color, secondary: Color) {
            self.main = main
            self.secondary = secondary
        }
        
        public convenience init(
            main: ConvertibleToColor,
            secondary: ConvertibleToColor
        ) {
            self.init(main: main.color, secondary: secondary.color)
        }
    }
    
    /// From the perspective of color design specifications, the higher the level, the lighter the color should be.
    public class ThreeLevel: SecondLevel {
        public let tertiary: Color
        
        public init(main: Color, secondary: Color, tertiary: Color) {
            self.tertiary = tertiary
            
            super.init(main: main, secondary: secondary)
        }
        
        public convenience init(
            main: ConvertibleToColor,
            secondary: ConvertibleToColor,
            tertiary: ConvertibleToColor
        ) {
            self.init(
                main: main.color,
                secondary: secondary.color,
                tertiary: tertiary.color
            )
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
            white: Color,
            black: Color
        ) {
            self.backgroundGray = backgroundGray
            self.auxiliaryGray = auxiliaryGray
            self.white = white
            self.black = black
        }
        
        public init(
            backgroundGray: ThreeLevel,
            auxiliaryGray: ThreeLevel,
            white: ConvertibleToColor,
            black: ConvertibleToColor
        ) {
            self.init(
                backgroundGray: backgroundGray,
                auxiliaryGray: auxiliaryGray,
                white: white.color,
                black: black.color
            )
        }
    }
    
    /// Define different colors according to usage scenarios.
    public struct Semantic {
        /// Theme color
        ///
        /// Provides two levels of theme colors,
        /// you can use different levels of theme colors according to the situation.
        public let theme: SecondLevel
        
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
            theme: SecondLevel,
            text: ThreeLevel,
            separator: Color,
            emphasis: ThreeLevel,
            border: Color,
            shadow: Color,
            unavailableText: Color
        ) {
            self.theme = theme
            self.text = text
            self.separator = separator
            self.emphasis = emphasis
            self.border = border
            self.shadow = shadow
            self.unavailableText = unavailableText
        }
        
        public init(
            theme: SecondLevel,
            text: ThreeLevel,
            separator: ConvertibleToColor,
            emphasis: ThreeLevel,
            border: ConvertibleToColor,
            shadow: ConvertibleToColor,
            unavailableText: ConvertibleToColor
        ) {
            self.init(
                theme: theme,
                text: text,
                separator: separator.color,
                emphasis: emphasis,
                border: border.color,
                shadow: shadow.color,
                unavailableText: unavailableText.color
            )
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
                main: .systemGroupedBackground,
                secondary: .secondarySystemGroupedBackground,
                tertiary: .tertiarySystemGroupedBackground
            ),
            auxiliaryGray: .init(
                main: .systemGray4,
                secondary: .systemGray5,
                tertiary: .systemGray6
            ),
            white: .tertiarySystemBackground,
            black: .label
        )
        
        let semanticConfig = Semantic(
            theme: .init(
                main: .systemIndigo,
                secondary: .systemIndigo.withAlphaComponent(0.8)
            ),
            text: .init(
                main: .label,
                secondary: .secondaryLabel,
                tertiary: .tertiaryLabel
            ),
            separator: .separator,
            emphasis: .init(
                main: .systemRed,
                secondary: .systemOrange,
                tertiary: .systemPink
            ),
            border: toolConfig.auxiliaryGray.main,
            shadow: toolConfig.black.color.withAlphaComponent(0.2),
            unavailableText: .systemGray
        )
        
        return Self(tool: toolConfig, semantic: semanticConfig)
    }()

    #elseif os(tvOS)
    
    #elseif os(watchOS)
    
    #endif
}
