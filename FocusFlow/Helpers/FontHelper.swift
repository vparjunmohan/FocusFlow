//
//  FontHelper.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import Foundation
import SwiftUI

/// A helper struct for managing custom fonts and applying them based on text styles and weights.
///
/// The `FontHelper` struct provides a convenient way to apply custom fonts to text views
/// in a SwiftUI application. It allows for the selection of different font weights and sizes
/// that align with the app's design requirements.
///
/// - `FontWeight`: An enum representing various font weights available in the custom font family.
///   Each case corresponds to a specific weight, which maps to a particular font file name.
///
///   - `extraLight`: Represents the "Poppins-ExtraLight" weight.
///   - `regular`: Represents the "Poppins-Regular" weight.
///   - `medium`: Represents the "Poppins-Medium" weight.
///   - `semiBold`: Represents the "Poppins-SemiBold" weight.
///   - `bold`: Represents the "Poppins-Bold" weight.
///   - `extraBold`: Represents the "Poppins-ExtraBold" weight.
///
///   Each case has an associated `fontName` property that returns the name of the custom font file.
///
/// - `applyFont(forTextStyle:weight:)`: A static method that returns a `Font` instance based on the
///   specified text style and weight.
///
///   - `textStyle`: The `Font.TextStyle` indicating the desired style (e.g., `.largeTitle`, `.body`).
///   - `weight`: The `FontWeight` specifying the desired weight for the font. Defaults to `.regular`.
///
///   Example usage:
///   ```
///   Text("Hello, World!")
///       .font(FontHelper.applyFont(forTextStyle: .title, weight: .bold))
///   ```
struct FontHelper {
    enum FontWeight {
        case extraLight, regular, medium, semiBold, bold, extraBold
        
        var fontName: String {
            switch self {
            case .extraLight:
                return "OpenSans-Light"
            case .regular:
                return "OpenSans-Regular"
            case .medium:
                return "OpenSans-Medium"
            case .semiBold:
                return "OpenSans-SemiBold"
            case .bold:
                return "OpenSans-Bold"
            case .extraBold:
                return "OpenSans-ExtraBold"
            }
        }
    }
    
    /// Returns a custom font based on the specified text style and weight.
    ///
    /// This function applies a custom font to a SwiftUI `Text` view, selecting the appropriate
    /// font size based on the provided `Font.TextStyle` and using the specified `FontWeight`.
    ///
    /// - Parameters:
    ///   - textStyle: The `Font.TextStyle` that dictates the font size and relative styling (e.g., `.title`, `.body`).
    ///   - weight: The `FontWeight` indicating the desired weight of the custom font. Defaults to `.regular`.
    ///
    /// - Returns: A `Font` instance configured with the custom font and size, adjusted for the provided text style.
    static func applyFont(forTextStyle textStyle: Font.TextStyle, weight: FontWeight = .regular) -> Font {
        let fontSize: CGFloat
        
        switch textStyle {
            /// Large title size of 34 points
        case .largeTitle:
            fontSize = 34
            
            /// Title size of 28 points
        case .title:
            fontSize = 28
            
            /// Secondary title size of 22 points
        case .title2:
            fontSize = 22
            
            /// Tertiary title size of 20 points
        case .title3:
            fontSize = 20
            
            /// Headline size of 17 points
        case .headline:
            fontSize = 17
            
            /// Subheadline size of 15 points
        case .subheadline:
            fontSize = 15
            
            /// Body text size of 17 points (matches headline size)
        case .body:
            fontSize = 17
            
            /// Callout size of 16 points
        case .callout:
            fontSize = 16
            
            /// Footnote size of 13 points
        case .footnote:
            fontSize = 13
            
            /// Caption size of 12 points
        case .caption:
            fontSize = 12
            
            /// Secondary caption size of 11 points
        case .caption2:
            fontSize = 11
            
            /// Default size of 17 points for unspecified text styles
        default:
            fontSize = 17
        }
        
        
        return .custom(weight.fontName, size: fontSize, relativeTo: textStyle)
    }
}
