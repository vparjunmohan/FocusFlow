//
//  Constants.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import Foundation
import SwiftUI

struct URLS {
    static let baseURL = "https://fqtpyipffielhhpurwmw.supabase.co"
    static let authKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxdHB5aXBmZmllbGhocHVyd213Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2NTYxODQsImV4cCI6MjAzOTIzMjE4NH0.aF48FZM2OM_zFcRVfCkShHELbg5i2dNRAgc7ZJMH4ws"
    static let serviceRoleKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxdHB5aXBmZmllbGhocHVyd213Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMzY1NjE4NCwiZXhwIjoyMDM5MjMyMTg0fQ.PD-gQwvxOEYQA5x0SGs-JFjn9y3pgMkyvKFEDlaNBMw"
}

/// A collection of standard spacer values used for consistent spacing throughout the app.
///
/// This struct defines common spacer sizes to ensure uniform spacing in the user interface.
/// It helps maintain a consistent layout and design language across different views.
///
/// - `xsmall`: Extra small spacer, typically used for very tight spacing.
/// - `small`: Small spacer, used for minor gaps or padding.
/// - `medium`: Medium spacer, for moderate gaps or padding.
/// - `large`: Large spacer, used for more noticeable gaps or padding.
struct AppSpacers {
    /// Extra small space of 4 points, used for very tight spacing
    static let xsmall: CGFloat = 4
    
    /// Small space of 8 points, used for minor gaps or padding
    static let small: CGFloat = 8
    
    /// Medium space of 12 points, used for moderate gaps or padding
    static let medium: CGFloat = 12
    
    /// Large space of 16 points, used for more noticeable gaps or padding
    static let large: CGFloat = 16
}

/// A collection of corner radius values used for rounded corners throughout the app.
///
/// This struct defines standard corner radius sizes to maintain consistent rounded corners
/// across different UI elements in the app.
///
/// - `large`: Large corner radius, typically used for buttons, cards, or other elements
///   that need a more pronounced rounded appearance.
struct AppCornerCurves {
    /// Large corner radius of 30 points, used for creating a pronounced rounded appearance
    static let large: CGFloat = 30
}

/// A collection of color values used for consistent theming throughout the app.
///
/// This struct defines color values that are used to maintain a cohesive color scheme
/// across various UI elements in the app. It helps in ensuring a unified theme and
/// color palette.
///
/// - `themeColor`: The primary theme color for the app, defined in the asset catalog as "AppTheme".
/// - `cardColor`: The color used for card backgrounds, defined in the asset catalog as "AppCardColor".
struct AppColors {
    static let themeColor: Color = Color("AppTheme")
    static let cardColor: Color = Color("AppCardColor")
}
