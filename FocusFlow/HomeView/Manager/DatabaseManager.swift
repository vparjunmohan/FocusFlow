//
//  DatabaseManager.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation
import Supabase

class DatabaseManager {
    
    static let shared = DatabaseManager()
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: URLS.baseURL)!, supabaseKey: URLS.authKey)
    
    func createTodoItem(item: TodoPayload) async throws {
        let response = try await client
            .from(TableManager.todos)
            .insert(item)
            .execute()
    }
    
    func fetchToDoItems(userUid: String) async throws -> [Todos] {
        let response = try await client
            .from(TableManager.todos)
            .select().eq("user_uid", value: userUid).order("created_at", ascending: false)
            .execute()
        let data = response.data
        let decoder = JSONDecoder()
        let todos = try decoder.decode([Todos].self, from: data)
        print(todos)
        return todos
    }
}
