//
//  ToDoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI

/// A view displaying a list of to-do items.
///
/// `ToDoView` is a SwiftUI view responsible for presenting and managing a list of to-do items.
/// It observes the ``ToDoViewModel`` for task data and the ``AuthViewModel`` for user authentication information.
/// The view responds to changes in these view models to update the UI accordingly.
struct ToDoView: View {
    @ObservedObject var viewModel: ToDoViewModel
    @ObservedObject var appUserInfo: AuthViewModel
    
    var body: some View {
        ZStack {
            todoListView
        }
        .onAppear(perform: fetchToDoItems)
    }
    
    // MARK: - Subviews
    /// A view displaying a vertically scrollable list of to-do items.
    ///
    /// The `todoListView` is a `LazyVStack` that efficiently lays out and displays each
    /// to-do item from the `viewModel.todoList`. Each item is rendered as a `Text` view
    /// showing the task description. The `ForEach` loop ensures that each to-do item is
    /// uniquely identified by its `id`, allowing SwiftUI to handle updates and re-rendering
    /// efficiently as the list changes.
    var todoListView: some View {
        LazyVStack(spacing: AppSpacers.medium) {
            ForEach(viewModel.todoList, id: \.id) { todo in
                TaskView(todos: todo)
            }
        }
        .padding(.all, AppSpacers.large)
    }
    
    // MARK: - Actions
    /// Fetches to-do items asynchronously from the view model.
    ///
    /// The `fetchToDoItems` function initiates an asynchronous task to fetch the list of to-do items
    /// using the `viewModel.fetchItems` method. It passes the current user's ID (obtained from
    /// `appUserInfo.appUser?.id`) to the method. If the fetch operation succeeds, the to-do items
    /// are updated in the view model. If an error occurs during the fetch, it is caught and logged
    /// to the console.
    ///
    /// This function is typically called when the view appears to ensure that the latest to-do
    /// items are loaded and displayed.
    func fetchToDoItems() {
        Task {
            do {
                try await viewModel.fetchItems(uid: appUserInfo.appUser?.id ?? "")
            } catch {
                print("Error fetching todos")
            }
        }
    }
}

#Preview {
    ToDoView(viewModel: ToDoViewModel(), appUserInfo: .init())
}
