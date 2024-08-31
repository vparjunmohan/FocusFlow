//
//  TaskView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 18/08/24.
//

import SwiftUI

/// A view representing a single task in a task list.
///
/// `TaskView` is a custom SwiftUI view that visually represents an individual task.
/// It displays a button to mark the task as complete, the task's title and due date,
/// and an icon indicating the task's priority. The layout is designed with consistent
/// spacing, padding, and styling to ensure a cohesive appearance in the app.
struct TaskView: View {
    
    var todos: Todos
    
    /// A horizontal stack displaying a task completion button, task details, and a spacer for layout.
    ///
    /// This view arranges the task's elements in a horizontal line with a large spacing between them.
    /// It includes a button to mark the task as completed, the task details (title, date, and priority),
    /// and a spacer to push the elements to the left, ensuring a balanced layout. The entire stack is
    /// padded uniformly and contained within a rounded rectangle with a background color, giving it
    /// a card-like appearance. The height is fixed at 70 points to maintain a consistent visual style.
    var body: some View {
        HStack(spacing: AppSpacers.large) {
            
            taskCompletionButton
            
            taskDetails
            
            Spacer(minLength: 0)
        }
        .padding(.all, AppSpacers.large)
        .frame(height: AppComponentSize.taskViewHeight)
        .background(AppColors.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.small))
    }
    
    // MARK: - Subviews
    /// A button representing the task completion status.
    ///
    /// The `taskCompletionButton` is a circular button that, when tapped, triggers an action
    /// to mark the task as complete. It uses a resizable system image (a circle) to visually
    /// indicate the completion state. The button's size is defined by the `AppIconSize.medium`
    /// to ensure consistency with other UI elements.
    var taskCompletionButton: some View {
        Button(action: {
            // Action for task completion
        }) {
            Image(systemName: "circle")
                .resizable()
                .frame(width: AppIconSize.medium, height: AppIconSize.medium)
        }
    }
    
    /// A vertical stack displaying the task's title, due date, and priority level (if available).
    ///
    /// The `taskDetails` view presents the primary information about a task, including:
    /// - **Title:** The title of the task, styled using the headline font for prominence.
    /// - **Due Date:** The due date of the task, if available, formatted as "dd-MM". It is displayed using a smaller subheadline font.
    /// - **Priority Level:** If a priority is specified, it is shown with bold text and a background color that reflects its priority level. The priority text is styled using a subheadline font and is displayed with padding and rounded corners.
    ///
    /// The view is designed with:
    /// - **Alignment:** All text elements are aligned to the leading edge.
    /// - **Spacing:** There is appropriate vertical spacing between the title and the date/priority elements, and horizontal spacing between the date and priority elements.
    ///
    /// **Notes:**
    /// - The due date is fetched using the `getDueDate` function, which converts a Unix timestamp to a formatted string.
    /// - The priority level is determined by the `getPriority` function and styled with a background color provided by `updateTaskPriority`.
    /// - An `EmptyView` is used if no priority is specified.
    ///
    /// - Parameters:
    ///   - `todos`: The model object containing the task details.
    var taskDetails: some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(todos.task)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
            HStack(spacing: AppSpacers.medium) {
                // TODO: Remove this check later
                let duedate = getDueDate(timestamp: todos.duedate ?? 0)
                if !duedate.isEmpty {
                    Text(duedate)
                        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
                }
                if !todos.priority.isEmpty {
                    Text(getPriority(todo: todos))
                        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(AppSpacers.xxsmall)
                        .padding(.horizontal, AppSpacers.xxsmall)
                        .background(
                            RoundedRectangle(cornerRadius: AppSpacers.xsmall)
                                .fill(updateTaskPriority(todo: todos))
                        )
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    /// Returns the appropriate color for a given to-do item's priority.
    ///
    /// The `updateTaskPriority` function maps the `priority` string of a `Todos` object to a specific color.
    /// This color is used to visually represent the priority of the task in the UI.
    ///
    /// - Parameter todo: A `Todos` object containing the priority information.
    /// - Returns: A `Color` corresponding to the task's priority. If the priority doesn't match any predefined values, `Color.clear` is returned.
    func updateTaskPriority(todo: Todos) -> Color {
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
    func getPriority(todo: Todos) -> String {
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
    func getDueDate(timestamp: Int) -> String {
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


#Preview {
    TaskView(todos: .init(id: 1, createdAt: "12/8", task: "Task 1", taskDescription: "userid", priority: "", userUID: "priority 1", duedate: 123432))
}
