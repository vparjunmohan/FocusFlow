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
/// - `task`: The title or name of the to-do item.
/// - `taskDescription`: A detailed description of the to-do item.
/// - `priority`: The priority level assigned to the to-do item.
/// - `userUID`: The unique identifier of the user who created the to-do item.
///
/// The `CodingKeys` enum maps the JSON keys to the struct properties, ensuring that
/// the keys in the JSON response align with the property names in the struct.
struct Todos: Codable {
    let id: Int
    let createdAt: String
    let task: String
    let taskDescription: String
    let priority: String
    let userUID: String
    
    init(id: Int, createdAt: String, todo: String, userUID: String, taskDescription: String, priority: String) {
        self.id = id
        self.createdAt = createdAt
        self.task = todo
        self.taskDescription = taskDescription
        self.priority = priority
        self.userUID = userUID
    }
    
    enum CodingKeys: String, CodingKey {
        case id, task, priority
        case createdAt = "created_at"
        case taskDescription = "task_description"
        case userUID = "user_uid"
    }
}

/// A model representing the payload for creating a new to-do item, conforming to `Codable`.
///
/// The `TodoPayload` struct is used when creating a new to-do item in the database.
/// It includes the following properties:
/// - `task`: The title or name of the to-do item.
/// - `taskDescription`: A detailed description of the to-do item.
/// - `userUID`: The unique identifier of the user creating the to-do item.
/// - `priority`: The priority level assigned to the to-do item.
///
/// The `CodingKeys` enum maps the JSON keys to the struct properties, ensuring correct
/// encoding and decoding when interacting with the database or an API. Specifically:
/// - `taskDescription` is mapped to the key `task_description` in JSON.
/// - `userUID` is mapped to the key `user_uid` in JSON.
struct TodoPayload: Codable {
    let task: String
    let taskDescription: String
    let userUID: String
    let priority: String
    
    init(task: String, taskDescription: String, userUID: String, priority: String) {
        self.task = task
        self.taskDescription = taskDescription
        self.userUID = userUID
        self.priority = priority
    }
    
    enum CodingKeys: String, CodingKey {
        case task, priority
        case taskDescription = "task_description"
        case userUID = "user_uid"
    }
}
