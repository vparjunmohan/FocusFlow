//
//  FontHelper.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import Foundation
import SwiftUI

struct FontHelper {
    enum FontWeight {
        case regular, medium, semiBold, bold, extraBold
        
        var fontName: String {
            switch self {
            case .regular:
                return "Poppins-Regular"
            case .medium:
                return "Poppins-Medium"
            case .semiBold:
                return "Poppins-SemiBold"
            case .bold:
                return "Poppins-Bold"
            case .extraBold:
                return "Poppins-ExtraBold"
            }
        }
    }

    static func applyFont(forTextStyle textStyle: Font.TextStyle, weight: FontWeight = .regular) -> Font {
        let fontSize: CGFloat

        switch textStyle {
        case .largeTitle:
            fontSize = 34
        case .title:
            fontSize = 28
        case .title2:
            fontSize = 22
        case .title3:
            fontSize = 20
        case .headline:
            fontSize = 17
        case .subheadline:
            fontSize = 15
        case .body:
            fontSize = 17
        case .callout:
            fontSize = 16
        case .footnote:
            fontSize = 13
        case .caption:
            fontSize = 12
        case .caption2:
            fontSize = 11
        default:
            fontSize = 17
        }

        return .custom(weight.fontName, size: fontSize, relativeTo: textStyle)
    }
}
