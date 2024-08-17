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
    @ObservedObject var viewModel: ToDoViewModel
    @EnvironmentObject var appUserViewModel: AuthViewModel
    @Binding var createTodoPresented: Bool
    @State var todoTitle: String = ""
    @State var todoDescription: String = ""
    @FocusState var isTodoTitleFocused: Bool
    
    var titlePlaceholder: String = "e.g., Go to gym tomorrow"
    var descriptionPlaceholder: String = "Description"
    
    var body: some View {
        ZStack {
            AppColors.appBgColor.ignoresSafeArea()
            VStack {
                todoTitleField
                todoDescriptionEditor
                submitButton
            }
        }
    }
    
    // MARK: - COMPONENTS
    /// A text field for entering the title of a new to-do item.
    ///
    /// This text field allows the user to input the title of the to-do item. It is styled
    /// with a semi-bold title3 font and has horizontal and top padding to provide adequate
    /// spacing around the field. The text entered by the user is bound to the `todoTitle`
    /// state variable, ensuring that changes are reflected in real-time.
    var todoTitleField: some View {
        TextField(titlePlaceholder, text: $todoTitle)
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
    
    /// A button for submitting the new to-do item.
    ///
    /// This button is used to trigger the action of submitting the new to-do item. It is
    /// styled as a circular button with a theme color background and an upward arrow icon.
    /// The button is placed within an `HStack` with spacers to align it to the right side
    /// of its container, and it includes padding for spacing around the button.
    ///
    /// The button's action is linked to the ``submitTodo`` method, which handles the logic
    /// for saving or processing the new to-do item.
    var submitButton: some View {
        HStack {
            Spacer()
            Button(action: submitTodo, label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(AppColors.themeColor)
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                }
            })
            .padding(.horizontal, AppSpacers.large)
            .padding(.vertical, AppSpacers.small)
        }
    }
    
    // MARK: - ACTIONS
    /// Submits the new to-do item.
    ///
    /// This function is triggered when the user taps the submit button. It performs the following steps:
    /// 1. Creates a new to-do item using the ``ToDoViewModel``'s ``createItem`` method, passing the title of the to-do
    ///    and the user's unique identifier (`userUID`). The user ID is retrieved from the ``AuthViewModel``.
    /// 2. Upon successful creation of the to-do item, the `createTodoPresented` state is toggled to dismiss
    ///    the current view and return to the previous screen.
    /// 3. If an error occurs during the item creation, an error message is printed to the console.
    ///
    /// This function is asynchronous and uses Swift’s concurrency model (`async/await`) to handle the task.
    func submitTodo() {
        Task {
            do {
                try await viewModel.createItem(text: todoTitle, userUID: appUserViewModel.appUser?.id ?? "")
                createTodoPresented.toggle()
            } catch {
                print("Failed to create todo")
            }
        }
    }
}


#Preview {
    CreateTodoView(viewModel: ToDoViewModel(), createTodoPresented: .constant(false))
        .environmentObject(AuthViewModel()) // Inject the environment object for appUserViewModel
}
