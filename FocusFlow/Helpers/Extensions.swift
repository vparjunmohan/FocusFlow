//
//  Extensions.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import Foundation
import SwiftUI

extension View {
    /// Configures the background color of the TabView by setting the UITabBar's appearance.
    ///
    /// - Parameter color: The `Color` to set as the background of the TabView.
    /// - Returns: The view with the configured TabView background color.
    func configureTabViewBackground(_ color: Color) -> some View {
        // Sets the background color of the UITabBar to the provided SwiftUI Color.
        UITabBar.appearance().backgroundColor = UIColor(color)
        return self
    }
}


// MARK: - UIApplication extensions
extension UIApplication {
    /// Retrieves the top-most view controller in the app's view hierarchy.
    ///
    /// This method recursively traverses the view controller hierarchy to find the top-most view controller,
    /// whether it's within a navigation stack, a tab bar controller, or a presented view controller.
    ///
    /// - Parameter base: The starting view controller to search from. Defaults to the root view controller of the first window.
    /// - Returns: The top-most `UIViewController` if found, or `nil` if there isn't one.
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        
        // If the base is a UINavigationController, get the visible view controller and continue the search.
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        // If the base is a UITabBarController, get the selected view controller and continue the search.
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        // If the base has a presented view controller, continue the search with the presented view controller.
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        // Return the current base view controller if no further view controllers are found.
        return base
    }
}
