//
//  CreateTodoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI

/// A view for creating a new to-do item.
///
/// The `CreateTodoView` provides an interface for users to enter the details of a new to-do item,
/// such as its title and description. It integrates with view models for managing to-do data and
/// authentication. This view is presented as a sheet and allows users to input and save new tasks.
struct CreateTodoView: View {
    @EnvironmentObject var appUserViewModel: AuthViewModel
    @StateObject var createTodoViewModel = CreateTodoViewModel()
    @ObservedObject var todoViewModel: ToDoViewModel
    @Binding var createTodoPresented: Bool
    @State var todoTitle: String = ""
    @State var todoDescription: String = ""
    @State private var showPicker = false
    @FocusState var isTodoTitleFocused: Bool
    
    var titlePlaceholder: String = "e.g., Go to gym tomorrow"
    var descriptionPlaceholder: String = "Description"
    
    var body: some View {
        ZStack {
            AppColors.appBgColor.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 0) {
                todoTitleField
                
                todoDescriptionEditor
                
                VStack(alignment: .leading, spacing: AppSpacers.small) {
                    if showPicker {
                        PriorityListView(selectedPriority: $createTodoViewModel.selectedPriority, showPicker: $showPicker)
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: showPicker)
                    }
                    priorityButton
                }
                
                divider
                
                submitButton
            }
        }
        .onAppear {
            isTodoTitleFocused = true
        }
    }
    
    // MARK: - Subviews
    /// A text field for entering the title of a new to-do item.
    ///
    /// This text field allows the user to input the title of the to-do item. It is styled
    /// with a semi-bold title3 font and has horizontal and top padding to provide adequate
    /// spacing around the field. The text entered by the user is bound to the `todoTitle`
    /// state variable, ensuring that changes are reflected in real-time.
    var todoTitleField: some View {
        TextField(titlePlaceholder, text: $todoTitle)
            .focused($isTodoTitleFocused)
            .font(FontHelper.applyFont(forTextStyle: .title3, weight: .semiBold))
            .padding(.horizontal, AppSpacers.large)
            .padding(.top, AppSpacers.large)
    }
    
    /// A text editor for entering the description of a new to-do item.
    ///
    /// This text editor allows the user to input a detailed description for the to-do item.
    /// It is styled with a regular body font and has horizontal padding for spacing. The
    /// editor's background color is set to match the app's background color using `colorMultiply`.
    ///
    /// A placeholder text is displayed when the editor is empty, providing guidance on what
    /// to enter. The placeholder text is styled with a gray color and is positioned slightly
    /// offset from the editor's edges. The placeholder does not intercept user interactions
    /// due to `allowsHitTesting(false)`.
    var todoDescriptionEditor: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $todoDescription)
                .font(FontHelper.applyFont(forTextStyle: .body, weight: .regular))
                .colorMultiply(AppColors.appBgColor)
                .padding(.horizontal, AppSpacers.large)
            
            if todoDescription.isEmpty {
                Text(descriptionPlaceholder)
                    .font(FontHelper.applyFont(forTextStyle: .body, weight: .regular))
                    .allowsHitTesting(false)
                    .foregroundStyle(.gray.opacity(0.5))
                    .padding(.horizontal, AppSpacers.large)
                    .offset(x: 5, y: 8)
            }
        }
    }
    
    /// A button that allows the user to select or change the priority level for a task.
    ///
    /// - Action: When tapped, the button toggles the visibility of the priority picker with an animated transition.
    /// - Appearance: The button displays a flag icon that reflects the current priority level.
    ///   If a priority is selected, the icon is filled (`flag.fill`); otherwise, it shows an unfilled flag (`flag`).
    ///   The button also displays the current priority title next to the icon.
    ///   The text and icon are styled with a custom font and the selected priority's color. If no color is set, a default label color is used.
    ///   The button has padding, a rounded rectangle background with a stroked border, and is positioned with additional leading padding.
    /// - Layout: The button is constrained to a specific height and internally padded horizontally and vertically for a balanced layout.
    var priorityButton: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                showPicker.toggle()
            }
        } label: {
            HStack {
                Image(systemName: (createTodoViewModel.selectedPriority.name?.isEmpty == false) ? "flag.fill" : "flag")
                Text(
                    createTodoViewModel.updatePriorityTitle(priority: createTodoViewModel.selectedPriority)
                )
                .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .medium))
            }
            .foregroundStyle(createTodoViewModel.selectedPriority.priorityColor ?? AppColors.labelColor)
            .padding(.horizontal, AppSpacers.medium)
            .padding(.vertical, AppSpacers.small)
            .background(
                RoundedRectangle(cornerRadius: AppCornerCurves.xsmall)
                    .stroke(AppColors.stokeColor, lineWidth: 1)
            )
        }
        .padding(.leading, AppSpacers.large)
        .frame(height: AppComponentSize.taskOptionsButtonHeight)
    }
    
    /// A custom divider view used to separate sections of content.
    ///
    /// This view consists of a `Rectangle` filled with a stroke color from `AppColors`.
    /// The rectangle has a fixed height of 1 point and spans the maximum available width.
    /// The divider also includes a top padding to add space before it is rendered.
    ///
    /// - The fill color is determined by the `AppColors.stokeColor`.
    /// - The height is fixed to 1 point.
    /// - The width is set to span the entire available width (`maxWidth`).
    /// - Top padding is applied using `AppSpacers.medium`.
    var divider: some View {
        Rectangle()
            .fill(AppColors.stokeColor)
            .frame(height: 1)
            .frame(maxWidth: .infinity)
            .padding(.top, AppSpacers.medium)
    }
    
    /// A button for submitting the new to-do item.
    ///
    /// This button is used to trigger the action of submitting the new to-do item. It is
    /// styled as a circular button with a theme color background and an upward arrow icon.
    /// The button is placed within an `HStack` with spacers to align it to the right side
    /// of its container, and it includes padding for spacing around the button.
    ///
    /// The button's action is linked to the `submitTodo` method, which handles the logic
    /// for saving or processing the new to-do item.
    var submitButton: some View {
        HStack {
            Spacer()
            Button(action: submitTodo, label: {
                ZStack {
                    Circle()
                        .frame(width: AppIconSize.xlarge, height: AppIconSize.xlarge)
                        .foregroundStyle(AppColors.themeColor)
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: AppIconSize.xsmall, height: AppIconSize.xsmall)
                        .foregroundStyle(.white)
                }
            })
            .padding(.horizontal, AppSpacers.large)
            .padding(.vertical, AppSpacers.medium)
        }
    }
    
    // MARK: - Actions
    /// Submits the new to-do item.
    ///
    /// This function is triggered when the user taps the submit button. It performs the following steps:
    /// 1. Creates a new to-do item using the ``ToDoViewModel``'s `createItem` method, passing the title of the to-do
    ///    and the user's unique identifier (`userUID`). The user ID is retrieved from the ``AuthViewModel``.
    /// 2. Upon successful creation of the to-do item, the `createTodoPresented` state is toggled to dismiss
    ///    the current view and return to the previous screen.
    /// 3. If an error occurs during the item creation, an error message is printed to the console.
    ///
    /// This function is asynchronous and uses Swift’s concurrency model (`async/await`) to handle the task.
    func submitTodo() {
        Task {
            do {
                try await todoViewModel.createItem(text: todoTitle, description: todoDescription, userUID: appUserViewModel.appUser?.id ?? "")
                try await todoViewModel.fetchItems(uid: appUserViewModel.appUser?.id ?? "")
                createTodoPresented.toggle()
            } catch {
                print("Failed to create todo")
            }
        }
    }
}


#Preview {
    CreateTodoView(todoViewModel: .init(), createTodoPresented: .constant(false))
        .environmentObject(AuthViewModel()) // Inject the environment object for appUserViewModel
}
