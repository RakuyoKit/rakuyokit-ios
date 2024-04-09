//
//  Collection+RAK.swift
//  RakuyoKit
//
//  Created by Rakuyo on 2024/4/9.
//  Copyright © 2024 Rakuyo. All rights reserved.
//

import UIKit

/// Color configuration
///
/// We recommend that when defining colors, you define `Tool` first,
/// and then reuse those same colors through `Tool`.
@dynamicMemberLookup
public struct ColorConfig {
    public typealias Color = UIColor
    
    public class Level {
        public let main: Color
        
        public var color: Color { main }
        
        public init(_ color: Color) {
            self.main = color
        }
    }
    
    /// From the perspective of color design specifications, the higher the level, the lighter the color should be.
    public class SecondLevel: Level {
        public let secondary: Color
        
        public init(main: Color, secondary: Color) {
            self.secondary = secondary
            
            super.init(main)
        }
    }
    
    /// From the perspective of color design specifications, the higher the level, the lighter the color should be.
    public class ThreeLevel: SecondLevel {
        public let tertiary: Color
        
        public init(main: Color, secondary: Color, tertiary: Color) {
            self.tertiary = tertiary
            
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
        public let white: Level
        
        /// Please use this property instead of `UIColor.black` when using white in your project
        public let black: Level
        
        public init(
            backgroundGray: ThreeLevel,
            auxiliaryGray: ThreeLevel,
            white: Level,
            black: Level
        ) {
            self.backgroundGray = backgroundGray
            self.auxiliaryGray = auxiliaryGray
            self.white = white
            self.black = black
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
        public let separator: Level
        
        /// Emphasis color.
        ///
        /// Provides three levels of choices for expressing *errors*, *warnings*, and *emphasis*.
        /// Recommendation: As the level increases, the degree should decrease: `main` represents `error`.
        public let emphasis: ThreeLevel
        
        /// Border color
        ///
        /// If you need transparency, you need to handle it yourself when defining the color value.
        public let border: Level
        
        /// Shadow color.
        ///
        /// If you need transparency, you need to handle it yourself when defining the color value.
        public let shadow: Level
        
        /// Text color when expressing "unavailable".
        ///
        /// Color commonly used when buttons are not clickable.
        public let unavailableText: Level
        
        public init(
            theme: SecondLevel,
            text: ThreeLevel,
            separator: Level,
            emphasis: ThreeLevel,
            border: Level,
            shadow: Level,
            unavailableText: Level
        ) {
            self.theme = theme
            self.text = text
            self.separator = separator
            self.emphasis = emphasis
            self.border = border
            self.shadow = shadow
            self.unavailableText = unavailableText
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

public extension ColorConfig {
    subscript<T>(dynamicMember keyPath: KeyPath<Tool, T>) -> T {
        return tool[keyPath: keyPath]
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<Semantic, T>) -> T {
        return semantic[keyPath: keyPath]
    }
}

// MARK: - Placeholder

public extension ColorConfig {
#if os(iOS) || os(visionOS)
    static let placeholder: Self = {
        let toolConfig = Tool(
            backgroundGray: .init(
                main: .systemGroupedBackground,
                secondary: .secondarySystemGroupedBackground,
                tertiary: .tertiarySystemGroupedBackground),
            auxiliaryGray: .init(
                main: .systemGray4,
                secondary: .systemGray5,
                tertiary: .systemGray6),
            white: .init(.tertiarySystemBackground),
            black: .init(.label))
        
        let semanticConfig = Semantic(
            theme: .init(
                main: .systemIndigo,
                secondary: .systemIndigo.withAlphaComponent(0.8)),
            text: .init(
                main: .label,
                secondary: .secondaryLabel,
                tertiary: .tertiaryLabel),
            separator: .init(.separator),
            emphasis: .init(
                main: .systemRed,
                secondary: .systemOrange,
                tertiary: .systemPink),
            border: .init(toolConfig.auxiliaryGray.main),
            shadow: .init(toolConfig.black.color.withAlphaComponent(0.2)),
            unavailableText: .init(.systemGray))
        
        return Self(tool: toolConfig, semantic: semanticConfig)
    }()
#elseif os(tvOS)
    
#elseif os(watchOS)
    
#endif
}
