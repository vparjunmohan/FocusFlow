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
        todoListView
            .onAppear(perform: fetchToDoItems)
    }
    
    // MARK: - Subviews
    /// The main view for displaying the list of todo items or a loading shimmer effect.
    ///
    /// This view adapts its content based on the loading state of the viewModel:
    /// - When loading, it displays a shimmer effect using `loadingView`.
    /// - When loaded, it shows the actual todo items using `loadedContentView`.
    ///
    /// The use of `LazyVStack` ensures efficient loading and scrolling performance,
    /// especially for long lists of items.
    private var todoListView: some View {
        LazyVStack(spacing: AppSpacers.medium) {
            if viewModel.isLoading {
                loadingView
            } else {
                loadedContentView
            }
        }
        .id(viewModel.isLoading) // Force view refresh based on loading state
        .padding(.all, AppSpacers.large)
    }
    
    /// A view that displays a shimmer effect to indicate that todo items are loading.
    ///
    /// This view creates a series of ``TaskViewShimmer`` instances, which visually
    /// represent the structure of todo items while they're being fetched.
    /// The number of shimmer items is determined by `numberOfShimmerItems`,
    /// providing a consistent and appealing loading state.
    private var loadingView: some View {
        ForEach(0..<numberOfShimmerItems, id: \.self) { _ in
            TaskViewShimmer()
        }
    }
    
    /// A view that displays the list of loaded todo items.
    ///
    /// Once the data is loaded, this view iterates through `viewModel.todoList`,
    /// creating a `TaskView` for each todo item. It uses the `id` of each todo item
    /// for efficient diffing and updating of the list.
    ///
    /// The use of `ForEach` here allows SwiftUI to optimize the rendering and
    /// updating of list items, particularly useful for long or frequently changing lists.
    private var loadedContentView: some View {
        ForEach(viewModel.todoList, id: \.id) { todo in
            NavigationLink(destination: DetailedTodoView(todo: todo)) {
                TaskView(todos: todo)
            }
        }
    }
    
    /// Determines the number of shimmer items to display while loading.
    ///
    /// This computed property calculates the number of shimmer items to show based on the current
    /// number of todo items, with a minimum of 7 and a maximum of 10. This approach ensures that:
    /// 1. There's always a reasonable number of shimmer items visible during loading.
    /// 2. The number of shimmer items roughly matches the expected number of actual items.
    /// 3. We don't overload the view with too many shimmer items on larger lists.
    ///
    /// - Returns: An integer between 5 and 10, inclusive.
    private var numberOfShimmerItems: Int {
        min(10, max(7, viewModel.todoList.count))
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
    private func fetchToDoItems() {
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
