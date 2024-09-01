//
//  Constants.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import Foundation
import SwiftUI



//MARK: - Constants
struct URLS {
    static let baseURL = "https://fqtpyipffielhhpurwmw.supabase.co"
    static let authKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxdHB5aXBmZmllbGhocHVyd213Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM2NTYxODQsImV4cCI6MjAzOTIzMjE4NH0.aF48FZM2OM_zFcRVfCkShHELbg5i2dNRAgc7ZJMH4ws"
    static let serviceRoleKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZxdHB5aXBmZmllbGhocHVyd213Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcyMzY1NjE4NCwiZXhwIjoyMDM5MjMyMTg0fQ.PD-gQwvxOEYQA5x0SGs-JFjn9y3pgMkyvKFEDlaNBMw"
}

//MARK: - AppSpacers
/// A collection of standard spacer values used for consistent spacing throughout the app.
///
/// This struct defines common spacer sizes to ensure uniform spacing in the user interface.
/// It helps maintain a consistent layout and design language across different views.
///
/// - `unity`: Very small spacer, typically used for very tight spacing.
/// - `xxsmall`: Extra small spacer, typically used for very tight spacing.
/// - `xsmall`: Extra small spacer, typically used for very tight spacing.
/// - `small`: Small spacer, used for minor gaps or padding.
/// - `medium`: Medium spacer, for moderate gaps or padding.
/// - `large`: Large spacer, used for more noticeable gaps or padding.
struct AppSpacers {
    /// A  small space of 1 points, used for stroke or very thin line
    static let unity: CGFloat = 1
    
    /// Extra small space of 2 points, used for very tight spacing
    static let xxsmall: CGFloat = 2
    
    /// Extra small space of 4 points, used for very tight spacing
    static let xsmall: CGFloat = 4
    
    /// Small space of 8 points, used for minor gaps or padding
    static let small: CGFloat = 8
    
    /// Medium space of 12 points, used for moderate gaps or padding
    static let medium: CGFloat = 12
    
    /// Large space of 16 points, used for more noticeable gaps or padding
    static let large: CGFloat = 16
    
    /// xLarge space of 20 points, used for more noticeable gaps or padding
    static let xlarge: CGFloat = 20
    
    /// xxLarge space of 24 points, used for more noticeable gaps or padding
    static let xxlarge: CGFloat = 24
    
    /// xxxLarge space of 28 points, used for more noticeable gaps or padding
    static let xxxlarge: CGFloat = 28
}

//MARK: - AppIconSize
/// A struct that defines standard sizes for app icons.
///
/// `AppIconSize` provides a set of predefined icon sizes used throughout the app. These sizes
/// are represented as static constants of type `CGFloat`, making it easy to maintain consistent
/// icon dimensions across different parts of the UI.
struct AppIconSize {
    /// xSmall icon size of 16 points.
    static let xsmall: CGFloat = 10
    
    /// Small icon size of 16 points.
    static let small: CGFloat = 16
    
    /// Medium icon size of 20 points.
    static let medium: CGFloat = 20
    
    /// Large icon size of 25 points.
    static let large: CGFloat = 25
    
    /// xLarge icon size of 30 points.
    static let xlarge: CGFloat = 35
    
    /// xxLarge icon size of 50 points.
    static let xxlarge: CGFloat = 50
}

// MARK: - AppCornerCurves
/// A struct that defines standard corner radius values for rounded corners throughout the app.
///
/// `AppCornerCurves` provides a set of predefined corner radius sizes that can be used across
/// various UI elements to ensure consistency in the app's design. These values help maintain
/// a cohesive visual style by standardizing the rounding of corners on components like buttons,
/// cards, and other UI elements.
struct AppCornerCurves {
    /// xSmall corner radius of 4 points, typically used for smaller rounding on the components.
    static let xsmall: CGFloat = 8
    
    /// Small corner radius of 20 points, typically used for subtle rounding on smaller components.
    static let small: CGFloat = 20
    
    /// Large corner radius of 28 points, used for creating a more pronounced rounded appearance
    /// on elements like buttons, cards, or containers.
    static let large: CGFloat = 28
}

//MARK: - AppComponentSize
/// A struct that defines standard sizes for various UI components in the app.
///
/// `AppComponentSize` provides a set of predefined dimensions used for different components,
/// ensuring consistency throughout the app's user interface. This includes standard sizes
/// such as button heights.
struct AppComponentSize {
    /// The standard height for buttons, set to 56 points.
    static let buttonHeight: CGFloat = 56
    
    /// The standard height for day brief card, set to 200 points.
    static let dayBriefCardHeight: CGFloat = 200
    
    /// The standard height for task view, set to 75 points.
    static let taskViewHeight: CGFloat = 75
    
    /// The standard height for task options button, set to 44 points.
    static let taskOptionsButtonHeight: CGFloat = 44
}

//MARK: - AppColors
/// A collection of color values used for consistent theming throughout the app.
///
/// This struct defines and centralizes the color values used across various UI elements
/// to maintain a cohesive and unified visual theme. The colors are defined in the app's
/// asset catalog and are used for backgrounds, text, buttons, and other components.
///
/// - `appBgColor`: The primary background color for the app, providing a consistent base throughout the UI.
/// - `cardColor`: The background color used for cards and other container views.
/// - `themeColor`: The primary tint color used across the app, giving prominence to key elements.
/// - `dangerColor`: The color used to indicate errors, warnings, or critical actions, providing clear visual feedback.
/// - `stokeColor`: The color used for strokes and borders around components, enhancing separation and emphasis.
/// - `labelColor`: The default color used for labels that include icons or images, ensuring text visibility and consistency.
/// - `priority1`: The color associated with "Priority 1" items, providing a visual cue for high-priority tasks.
/// - `priority2`: The color associated with "Priority 2" items, helping to differentiate between priority levels.
/// - `priority3`: The color associated with "Priority 3" items, ensuring a clear distinction among task priorities.
/// - `priority4`: The color associated with "Priority 4" items, maintaining a uniform approach to lower-priority tasks.
struct AppColors {
    static let appBgColor: Color = .appBg
    static let cardColor: Color = .appCard
    static let themeColor: Color = .appTheme
    static let dangerColor: Color = .appDanger
    static let stokeColor: Color = .appStroke
    static let labelColor: Color = .appLabel
    static let textColor: Color = .appText
    static let priority1: Color = .priority1
    static let priority2: Color = .priority2
    static let priority3: Color = .priority3
    static let priority4: Color = .priority4
}
