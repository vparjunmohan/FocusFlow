//
//  Todos.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

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

struct TodoPayload: Codable { // create identifiable
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
