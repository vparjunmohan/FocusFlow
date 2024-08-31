//
//  DatabaseManager.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation
import Supabase

/// Singleton class to manage database interactions with Supabase.
class DatabaseManager {
    
    /// Shared instance of `DatabaseManager` to be used throughout the app.
    static let shared = DatabaseManager()
    
    /// Private initializer to prevent creating additional instances of `DatabaseManager`.
    private init() {}
    
    /// Supabase client initialized with the base URL and authentication key.
    let client = SupabaseClient(supabaseURL: URL(string: URLS.baseURL)!, supabaseKey: URLS.authKey)
    
    /// Asynchronously creates a new to-do item in the database.
    /// - Parameter item: The `TodoPayload` object containing the data to be inserted.
    func createTodoItem(item: TodoPayload) async throws {
        try await client
            .from(TableManager.todos) 
            .insert(item)
            .execute()
    }
    
    /// Asynchronously fetches to-do items from the database for a specific user.
    /// - Parameter userUid: The unique identifier of the user whose to-do items are to be fetched.
    /// - Returns: An array of `Todos` objects representing the to-do items.
    func fetchToDoItems(userUid: String) async throws -> [Todos] {
        let response = try await client
            .from(TableManager.todos)
            .select()
            .eq("user_uid", value: userUid)
            .order("created_at", ascending: false)
            .execute()
        
        let data = response.data
        let decoder = JSONDecoder()
        let todos = try decoder.decode([Todos].self, from: data)
        return todos
    }
}

