//
//  PriorityModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 19/08/24.
//

import SwiftUI

/// A model representing a priority level with a corresponding color.
///
/// The `PriorityModel` struct is used to define a priority level for a to-do item,
/// including its name and associated color. This model can be used to visually
/// distinguish between different priority levels within the user interface.
///
/// - Parameters:
///   - name: The name of the priority level, e.g., "Priority 1", "Priority 2", "Priority 3 and "Priority 4".
///   - priorityColor: The color associated with the priority level,
///     which can be used for visual representation in the UI.
struct PriorityModel: Hashable {
    let name: String
    let priorityColor: Color
    
    static let priority1 = PriorityModel(name: "Priority 1", priorityColor: AppColors.priority1)
    static let priority2 = PriorityModel(name: "Priority 2", priorityColor: AppColors.priority2)
    static let priority3 = PriorityModel(name: "Priority 3", priorityColor: AppColors.priority3)
    static let priority4 = PriorityModel(name: "Priority 4", priorityColor: AppColors.priority4)
    
    static let allPriorities = [priority1, priority2, priority3, priority4]
}
