//
//  Helpers.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/09/24.
//

import SwiftUI

/// A singleton helper class providing utility methods related to task management.
///
/// The `Helpers` class contains utility functions for handling tasks' priorities,
/// including determining the appropriate color based on a task's priority and returning
/// shorthand representations of priority levels.
final class Helpers {
    
    /// A shared instance of the `Helpers` class for global access.
    static let shared = Helpers()
    
    /// Private initializer to prevent the creation of multiple instances.
    private init() {}
    
    /// Returns the appropriate color for a given to-do item's priority.
    ///
    /// The `updateTaskPriority` function maps the `priority` string of a `Todos` object to a specific color.
    /// This color is used to visually represent the priority of the task in the UI.
    ///
    /// - Parameter todo: A `Todos` object containing the priority information.
    /// - Returns: A `Color` corresponding to the task's priority. If the priority doesn't match any predefined values, `Color.clear` is returned.
    internal func updateTaskPriority(todo: Todos) -> Color {
        switch todo.priority {
        case "Priority 1":
            return AppColors.priority1
        case "Priority 2":
            return AppColors.priority2
        case "Priority 3":
            return AppColors.priority3
        case "Priority 4":
            return AppColors.priority4
        default:
            return Color.clear
        }
    }
    
    /// Returns a shorthand representation of the priority level for a given todo item.
    /// - Parameter todo: A `Todos` object containing the priority information.
    /// - Returns: A string representing the shorthand priority level ("P1", "P2", "P3", "P4"),
    ///            or an empty string if the priority does not match any predefined levels.
    internal func getPriority(todo: Todos) -> String {
        switch todo.priority {
        case "Priority 1":
            return "P1"
        case "Priority 2":
            return "P2"
        case "Priority 3":
            return "P3"
        case "Priority 4":
            return "P4"
        default:
            return ""
        }
    }
    
    /// Converts a Unix timestamp (in seconds) to a formatted date string ("dd-MM").
    ///
    /// This function takes an integer Unix timestamp as input and converts it to a `Date` object.
    /// It then formats the date into a string with the "dd-MM" format (day-month) using a `DateFormatter`.
    /// If the timestamp is valid (greater than 0), it returns the formatted date string.
    /// If the timestamp is invalid (0 or less), it returns an empty string.
    ///
    /// - Parameter timestamp: An integer representing the Unix timestamp in seconds.
    /// - Returns: A formatted date string ("dd-MM") if the timestamp is valid, or an empty string if invalid.
    internal func getDueDate(timestamp: Int) -> String {
        if timestamp > 0 {
            let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM"

            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return ""
        }
    }
}
