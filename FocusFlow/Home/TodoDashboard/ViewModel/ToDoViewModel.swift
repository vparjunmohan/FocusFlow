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
/// This class manages the creation and retrieval of to-do items.
///
/// - Properties:
///   - `createNewTodo`: An array of ``TodoPayload`` used to hold new to-do items
///     that are being created. This array is published, so any changes to it
///     will trigger a UI update.
///   - `todoList`: An array of ``Todos`` representing the list of to-do items
///     fetched from the data source. This is also a published property, ensuring
///     the UI updates when the list of to-dos changes.
class ToDoViewModel: ObservableObject {
    @Published var createNewTodo: [TodoPayload] = [TodoPayload]()
    @Published var todoList: [Todos] = []
        
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
    /// If the fetch operation succeeds, the `todoList` is updated with the fetched items. If an error occurs,
    /// it is caught and logged to the console.
    ///
    /// - Parameter uid: The unique identifier of the user whose to-do items are to be fetched.
    /// - Throws: An error if the to-do items could not be fetched from the database.
    @MainActor
    func fetchItems(uid: String) async throws {
        do {
            todoList = try await DatabaseManager.shared.fetchToDoItems(userUid: uid)
        } catch {
            print("unable to fetch the todo list")
        }
    }
    
    func deleteItem() async throws {
        
    }
}
