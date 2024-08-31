//
//  CreateTodoViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 24/08/24.
//

import SwiftUI

/// A view model that manages the data and logic for creating a to-do item.
///
/// The `CreateTodoViewModel` class is an `ObservableObject` that holds and updates the state related to creating a new to-do task.
/// It manages the currently selected priority, which is represented by a `PriorityModel`.
/// The `selectedPriority` property is marked with `@Published` to allow SwiftUI views to reactively update when the selected priority changes.
///
/// - Properties:
///   - `selectedPriority`: A `PriorityModel` representing the current priority level selected by the user.
///     This is initialized with a default `PriorityModel` instance and can be updated as the user interacts with the UI.
class CreateTodoViewModel: ObservableObject {
    
    @Published var selectedPriority: PriorityModel = PriorityModel()
    
    /// Returns a shortened title for a given priority based on its name.
    ///
    /// The `updatePriorityTitle(priority:)` function takes a `PriorityModel` as input and returns a corresponding
    /// abbreviated title string for the priority. The function uses a `switch` statement to map the priority's name
    /// to a shortened form (e.g., "Priority 1" is mapped to "P1"). If the priority name does not match any of the
    /// predefined cases, the function returns a default string "Priority".
    ///
    /// - Parameter priority: A `PriorityModel` representing the current priority.
    /// - Returns: A `String` containing the abbreviated title for the given priority.
    func updatePriorityTitle(priority: PriorityModel) -> String {
        switch priority.name {
        case "Priority 1":
            return "P1"
        case "Priority 2":
            return "P2"
        case "Priority 3":
            return "P3"
        case "Priority 4":
            return "P4"
        default:
            return "Priority"
        }
    }
}
