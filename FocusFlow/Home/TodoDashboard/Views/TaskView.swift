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
    /// The `taskDetails` view presents the main information about the task, including its title, due date,
    /// and priority level (if specified). The title is styled using the headline font, while the date and priority
    /// are displayed with a smaller subheadline font. If a priority is present, it is shown with bold text and
    /// a colored background based on its priority level. The text elements are aligned to the leading edge, with
    /// appropriate spacing between them, ensuring a clear and organized layout.
    var taskDetails: some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(todos.task)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
            HStack(spacing: AppSpacers.medium) {
                Text("18/08")
                    .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
                if !todos.priority.isEmpty {
                    Text(getPriority(todo: todos))
                        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .bold))
                        .foregroundStyle(AppColors.textColor)
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
}


#Preview {
    TaskView(todos: .init(id: 1, createdAt: "12/8", todo: "Task 1", userUID: "userid", taskDescription: "", priority: "priority 1"))
}
