//
//  ToDoViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

class ToDoViewModel: ObservableObject {
    @Published var createNewTodo: [TodoPayload] = [TodoPayload]()
    @Published var todoList: [Todos] = []
    
    func createItem(text: String, userUID: String) async throws {
        let todo = TodoPayload(todo: text, userUID: userUID)
        try await DatabaseManager.shared.createTodoItem(item: todo)
    }
    
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
