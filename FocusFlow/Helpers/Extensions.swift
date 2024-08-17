//
//  Extensions.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import Foundation
import SwiftUI

extension View {
    func configureTabViewBackground(_ color: Color) -> some View {
        UITabBar.appearance().backgroundColor = UIColor(color)
        return self
    }
}

// MARK: - UIApplication extensions
extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
