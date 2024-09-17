//
//  DetailedTodoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/09/24.
//

import SwiftUI

/// A view that displays the detailed information for a specific to-do item.
///
/// The `DetailedTodoView` shows all relevant details of a given `Todos` object,
/// allowing users to see additional information beyond the task's title or summary.
///
/// - Parameter todo: A `Binding` to a `Todos` object representing the specific task
///   whose details are to be displayed. This binding allows the view to both
///   display and update the task's information interactively.
struct DetailedTodoView: View {
    
    @Binding var todo: Todos
    @State var descriptionText: String = "Description"
    
    /// The main body of the `DetailedTodoView`, which displays detailed information about a to-do item.
    ///
    /// The view is organized using a vertical scrollable layout (`ScrollView`), allowing users to scroll through
    /// the task details if the content exceeds the screen height. It contains a `VStack` with a leading alignment
    /// to structure the to-do title, options, and description, with customizable spacing between these elements.
    ///
    /// - `todoTitleField`: Displays the title of the to-do item.
    /// - `optionView`: Displays additional options or metadata related to the to-do.
    /// - `todoDescription`: Shows a detailed description of the to-do item.
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacers.xlarge) {
            todoTitleField
            optionView
            todoDescription
            Spacer()
            deleteButtonView
        }
        .padding(.horizontal, AppSpacers.large)
        .padding(.top, AppSpacers.large)
        .navigationTitle("Details")
        .background(AppColors.surfacePrimary.ignoresSafeArea())
    }
    
    /// A text field for displaying and editing the title of the to-do item.
    ///
    /// The `todoTitleField` uses a `TextField` to show the `task` property of the `todo` object.
    /// It applies a bold font style for the title using a custom font helper, and sets the text color using
    /// the app's color scheme.
    ///
    /// - The text is bound to the `todo.task` property, but editing is disabled with an empty `set` function.
    /// - Font: Bold, title style.
    /// - Foreground color: `AppColors.textPrimary`.
    private var todoTitleField: some View {
        TextField("", text: $todo.task, axis: .vertical)
            .font(FontHelper.applyFont(forTextStyle: .title, weight: .bold))
            .foregroundStyle(AppColors.textPrimary)
    }
    
    /// A view that displays the labels for the created date, due date, and priority of the to-do item.
    ///
    /// The `dateView` contains three `Text` views for displaying static labels:
    /// "Created Date", "Due Date", and "Priority".
    ///
    /// - The labels use a semi-bold, callout style font and a tertiary text color.
    private var dateView: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text("Created Date")
            
            Text("Due Date")
            
            Text("Priority")
        }
        .font(FontHelper.applyFont(forTextStyle: .callout, weight: .semiBold))
        .foregroundStyle(AppColors.textTertiary)
    }
    
    /// A view that displays the actual values for the created date, due date, and priority of the to-do item.
    ///
    /// The `optionFillView` displays dynamic content: the created date, due date, and the priority.
    /// - `Text`: Displays formatted dates (hardcoded for now) and the priority using the `priorityView`.
    ///
    /// - Font: Regular, subheadline style.
    /// - Foreground color: `AppColors.textPrimary`.
    private var optionFillView: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text(formatCreatedDate(dateString: todo.createdAt))
                .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .medium))
            
            Text(Helpers.shared.getDueDate(timestamp: todo.duedate ?? 0))
                .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .medium))
            
            priorityView
        }
        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
        .foregroundStyle(AppColors.textPrimary)
    }
    
    /// A view that displays the priority of the to-do item as a badge.
    ///
    /// The `priorityView` uses a `Text` to display the priority of the `todo` item in a shorthand format.
    /// The text is styled with a bold, subheadline font, and the background color is determined by the
    /// priority of the task. It is presented in a rounded rectangle to create a badge-like appearance.
    ///
    /// - Font: Bold, subheadline style.
    /// - Background color: Dynamic, based on task priority.
    private var priorityView: some View {
        Text(Helpers.shared.getPriority(todo: todo))
            .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .bold))
            .foregroundStyle(.white)
            .padding(AppSpacers.xxsmall)
            .padding(.horizontal, AppSpacers.xxsmall)
            .background(
                RoundedRectangle(cornerRadius: AppSpacers.xsmall)
                    .fill(Helpers.shared.updateTaskPriority(todo: todo))
            )
    }
    
    /// A view that combines the `dateView` and `optionFillView` side by side.
    ///
    /// The `optionView` arranges the `dateView` and `optionFillView` horizontally with a medium-sized space
    /// between them, showing the labels and their corresponding values for the to-do item's created date,
    /// due date, and priority.
    private var optionView: some View {
        HStack(spacing: AppSpacers.medium) {
            dateView
            optionFillView
        }
    }
    
    /// A text field for displaying and editing the detailed description of the to-do item.
    ///
    /// The `todoDescription` view contains a `TextField` bound to the `taskDescription` property of the `todo` object.
    /// It includes a "Description" label above the text field to provide context for the user.
    ///
    /// - The text field is styled using the body font for the description content, while the label uses a callout style font.
    /// - Foreground colors: The label uses a tertiary text color, while the description text uses the primary text color.
    /// - Background: The text field has padding and is placed inside a rounded rectangle with a background color defined by `AppColors.cardColor`.
    /// - Spacing: The content has a vertical spacing defined by `AppSpacers.medium`.
    private var todoDescription: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text("Description")
                .font(FontHelper.applyFont(forTextStyle: .callout, weight: .semiBold))
                .foregroundStyle(AppColors.textTertiary)
            TextField(todo.taskDescription.isEmpty ? descriptionText : "", text: $todo.taskDescription, axis: .vertical)
                .font(FontHelper.applyFont(forTextStyle: .body))
                .foregroundStyle(AppColors.textPrimary)
                .padding(AppSpacers.medium)
                .background(AppColors.cardColor)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.xsmall))
        }
    }
    
    /// A button view designed for deleting a to-do item.
    ///
    /// This button displays a "Delete" label with customized font and foreground color. It spans the full width of its container
    /// and has a fixed height. The button's background color is set to a danger color to signify a delete action, and it is clipped
    /// to a rounded rectangle shape for styling. The `.buttonStyle(PlainButtonStyle())` modifier is applied to ensure that the button
    /// behaves consistently and the tap area includes the entire width and height of the button.
    private var deleteButtonView: some View {
        Button(action: {
            print(todo)
        }, label: {
            Text("Delete")
                .font(FontHelper.applyFont(forTextStyle: .body, weight: .semiBold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(AppColors.dangerColor)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.small))
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    /// Converts a date string from a specific format to a shorter `dd-MM` format.
    ///
    /// This function takes a date string (in the format `dd/MM/yyyy, hh:mm:ss a`),
    /// parses it into a `Date` object using an `inputFormatter`, and then re-formats
    /// it into the desired `dd-MM` format using an `outputFormatter`.
    ///
    /// - Parameter dateString: A string representing the date and time in the format `dd/MM/yyyy, hh:mm:ss a`.
    /// - Returns: A string representing the date in the `dd-MM` format. If the input string cannot be parsed, it returns an empty string.
    private func formatCreatedDate(dateString: String) -> String {
        let dateString = "15/09/2024, 11:07:56 PM"
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd/MM/yyyy, hh:mm:ss a"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd-MM"
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
}

#Preview {
    DetailedTodoView(todo: .constant(.init(id: 1, createdAt: "15/09/2024, 11:07:56 PM", task: "Have dinner @10p.m", taskDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tincidunt, eros et pretium lacinia, lectus quam lobortis nibh, vel malesuada sapien massa id magna. Etiam at molestie lectus. Maecenas laoreet eros quis scelerisque dignissim. Suspendisse potenti. Phasellus tristique imperdiet purus vitae ultrices. Donec consectetur dolor augue, id tincidunt massa dignissim id. Pellentesque quis dui libero. Aliquam erat nulla, viverra sit amet aliquam lobortis, feugiat vitae ligula.", priority: "Priority 3", userUID: "qwyefuig", duedate: 123323)))
}
