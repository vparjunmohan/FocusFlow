//
//  ToDoViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

/// ViewModel responsible for managing and providing data for the To-Do views.
///
/// The `ToDoViewModel` class conforms to the `ObservableObject` protocol, enabling
/// SwiftUI views to automatically update whenever the published properties change.
/// This class manages the creation, retrieval, and loading state of to-do items.
///
/// Properties:
/// - `createNewTodo`: An array of `TodoPayload` used to hold new to-do items
///   that are being created. This array is published, so any changes to it
///   will trigger a UI update.
/// - `todoList`: An array of `Todos` representing the list of to-do items
///   fetched from the data source. This is also a published property, ensuring
///   the UI updates when the list of to-dos changes.
/// - `isLoading`: A Boolean flag indicating whether the to-do list is currently
///   being fetched or updated. This allows the UI to show loading indicators
///   or shimmer effects when appropriate.
/// - `isDataLoaded`: A Boolean flag indicating whether the to-do list has been
///   successfully fetched and loaded. This flag helps to avoid unnecessary
///   re-fetching of data when the view appears multiple times, improving performance
///   by ensuring that the data is only fetched once unless explicitly reset.
class ToDoViewModel: ObservableObject {
    @Published var createNewTodo: [TodoPayload] = [TodoPayload]()
    @Published var todoList: [Todos] = []
    @Published var isLoading: Bool = false
    @Published var isDataLoaded: Bool = false
    
    /// Asynchronously creates a new to-do item and saves it to the database.
    ///
    /// The `createItem` function constructs a `TodoPayload` object with the provided parameters and
    /// saves it to the database using `DatabaseManager`. It performs the following steps:
    /// 1. Creates a `TodoPayload` object with the title, description, user UID, priority, and due date.
    /// 2. Calls `DatabaseManager.shared.createTodoItem` to save the to-do item to the database.
    ///
    /// If the operation fails, the function throws an error which should be handled by the caller.
    ///
    /// - Parameters:
    ///   - text: The title or name of the to-do item.
    ///   - description: A detailed description of the to-do item.
    ///   - userUID: The unique identifier of the user creating the to-do item.
    ///   - priority: The priority level assigned to the to-do item.
    ///   - duedate: The due date for the to-do item, represented as a Unix timestamp in seconds (`Int`).
    /// - Throws: An error if the to-do item could not be created or saved to the database.
    func createItem(text: String, description: String, userUID: String, priority: String, duedate: Int) async throws {
        let todo = TodoPayload(task: text, taskDescription: description, userUID: userUID, priority: priority, duedate: duedate)
        try await DatabaseManager.shared.createTodoItem(item: todo)
    }
    
    /// Asynchronously fetches the list of to-do items for a specific user and updates the `todoList`.
    ///
    /// The `fetchItems` function retrieves the to-do items from the database associated with the provided user UID.
    /// It first checks whether the data has already been loaded by evaluating the `isDataLoaded` flag.
    /// If the data is already loaded, the function returns early to avoid unnecessary re-fetching.
    /// If the data is not yet loaded, the function proceeds to fetch the items:
    /// - The `isLoading` state is set to `true` to indicate that the fetching process has started.
    /// - After the items are successfully fetched, they are assigned to `todoList`, and the `isDataLoaded` flag is set to `true` to prevent future re-fetching unless explicitly reset.
    /// - If an error occurs during the fetch operation, it is caught and logged to the console, but the UI will reflect that loading has completed by setting `isLoading` to `false`.
    ///
    /// - Parameter uid: The unique identifier of the user whose to-do items are to be fetched.
    /// - Throws: An error if the to-do items could not be fetched from the database.
    @MainActor
    func fetchItems(uid: String) async throws {
        guard !isDataLoaded else { return } // Skip fetching if data is already loaded
        isLoading = true
        do {
            todoList = try await DatabaseManager.shared.fetchToDoItems(userUid: uid)
            isDataLoaded = true // Mark data as loaded
        } catch {
            print("unable to fetch the todo list")
        }
        isLoading = false
    }
    
    func deleteItem() async throws {
        
    }
    
    /// Resets the to-do data and loading state in the view model.
    ///
    /// The `resetData` function clears the currently loaded to-do list and resets the
    /// `isDataLoaded` flag to `false`. This allows the view model to refetch the data
    /// the next time `fetchItems` is called. This function is useful when the to-do list
    /// needs to be refreshed or reloaded, such as after a user logs out or switches accounts.
    ///
    /// - The `todoList` is cleared, removing all to-do items from the list.
    /// - The `isDataLoaded` flag is set to `false`, indicating that the data needs to be
    ///   reloaded the next time it is requested.
    func resetData() {
        isDataLoaded = false
        todoList = []
    }
}
