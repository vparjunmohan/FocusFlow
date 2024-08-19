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
    var task: Todos
    
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
            Text(task.todo)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
            Text("18/08")
                .font(FontHelper.applyFont(forTextStyle: .caption, weight: .regular))
        }
    }
    
    /// An icon indicating the task's priority.
    ///
    /// The `taskPriorityFlag` is a simple image view that displays a flag icon. This icon
    /// serves as a visual indicator of the task's priority level. It uses a system image
    /// named "flag" to ensure a consistent appearance across different platforms.
    var taskPriorityFlag: some View {
        Image(systemName: "flag")
    }
}


#Preview {
    TaskView(task: .init(id: 1, createdAt: "12/8", todo: "Task 1", userUID: "userid"))
}
