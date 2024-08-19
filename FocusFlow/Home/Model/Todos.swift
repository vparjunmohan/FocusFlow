//
//  Todos.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

/// A model representing a to-do item, conforming to `Codable` for easy encoding and decoding.
///
/// The `Todos` struct defines the properties of a to-do item stored in the database, including:
/// - `id`: A unique identifier for the to-do item.
/// - `createdAt`: The timestamp when the to-do item was created.
/// - `todo`: The description or title of the to-do item.
/// - `userUID`: The unique identifier of the user who created the to-do item.
///
/// The `CodingKeys` enum is used to map the JSON keys to the struct properties, ensuring that
/// the keys in the JSON response align with the property names in the struct.
struct Todos: Codable {
    let id: Int
    let createdAt: String
    let todo: String
    let userUID: String
    
    init(id: Int, createdAt: String, todo: String, userUID: String) {
        self.id = id
        self.createdAt = createdAt
        self.todo = todo
        self.userUID = userUID
    }
    
    enum CodingKeys: String, CodingKey {
        case id, todo
        case createdAt = "created_at"
        case userUID = "user_uid"
    }
}

/// A model representing the payload for creating a new to-do item, conforming to `Codable`.
///
/// The `TodoPayload` struct is used when creating a new to-do item in the database.
/// It contains:
/// - `todo`: The description or title of the to-do item.
/// - `userUID`: The unique identifier of the user creating the to-do item.
///
/// The `CodingKeys` enum maps the JSON keys to the struct properties, ensuring proper
/// encoding and decoding when interacting with the database or an API.
struct TodoPayload: Codable {
    let todo: String
    let userUID: String
    
    init(todo: String, userUID: String) {
        self.todo = todo
        self.userUID = userUID
    }
    
    enum CodingKeys: String, CodingKey {
        case todo
        case userUID = "user_uid"
    }
}
