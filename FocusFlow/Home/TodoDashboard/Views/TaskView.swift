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
    private var taskCompletionButton: some View {
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
    private var taskDetails: some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(todos.task)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
                .foregroundStyle(AppColors.textPrimary)
            HStack(spacing: AppSpacers.medium) {
                // TODO: Remove this check later
                let duedate = Helpers.shared.getDueDate(timestamp: todos.duedate ?? 0)
                if !duedate.isEmpty {
                    Text(duedate)
                        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
                        .foregroundStyle(AppColors.textPrimary)
                }
                if !todos.priority.isEmpty {
                    Text(Helpers.shared.getPriority(todo: todos))
                        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .bold))
                        .foregroundStyle(.white)
                        .padding(AppSpacers.xxsmall)
                        .padding(.horizontal, AppSpacers.xxsmall)
                        .background(
                            RoundedRectangle(cornerRadius: AppSpacers.xsmall)
                                .fill(Helpers.shared.updateTaskPriority(todo: todos))
                        )
                } else {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    TaskView(todos: .init(id: 1, createdAt: "12/8", task: "Task 1", taskDescription: "userid", priority: "", userUID: "priority 1", duedate: 123432))
}
