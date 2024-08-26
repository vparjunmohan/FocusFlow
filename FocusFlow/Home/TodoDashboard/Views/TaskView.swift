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
    
    var body: some View {
        HStack(spacing: AppSpacers.large) {
            
            taskCompletionButton
            
            taskDetails
            
            Spacer(minLength: 0)
            
            taskPriorityFlag
        }
        .padding(.all, AppSpacers.large)
        .frame(height: 70)
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
    
    /// A vertical stack displaying the task's title and date.
    ///
    /// The `taskDetails` view presents the main information about the task, including its title and due date.
    /// The title is styled using the headline font, while the date is displayed with a smaller caption font.
    /// The text elements are aligned to the leading edge, with a small vertical spacing between them.
    var taskDetails: some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(todos.task)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
            Text("18/08")
                .font(FontHelper.applyFont(forTextStyle: .caption, weight: .regular))
        }
    }
    
    /// A view that displays a flag icon based on the priority of a to-do item.
    ///
    /// The `taskPriorityFlag` property conditionally displays a filled flag icon if the `priority` of the `todos` object is not empty.
    /// The color of the flag icon is determined by the `updateTaskPriority(todo:)` function, which maps the priority string to a corresponding color.
    /// If the priority is empty, the view will render an `EmptyView`, effectively showing nothing.
    ///
    /// - Returns: A `View` that displays a colored flag icon for the to-do item's priority or an empty view if no priority is set.
    var taskPriorityFlag: some View {
        Group {
            if !todos.priority.isEmpty {
                Image(systemName: "flag.fill")
                    .foregroundStyle(updateTaskPriority(todo: todos))
            } else {
                EmptyView()
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
}


#Preview {
    TaskView(todos: .init(id: 1, createdAt: "12/8", todo: "Task 1", userUID: "userid", taskDescription: "", priority: "priority 1"))
}
