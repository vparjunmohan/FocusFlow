//
//  ToDoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI

struct ToDoView: View {
    @ObservedObject var viewModel: ToDoViewModel
    @ObservedObject var appUserInfo: AuthViewModel
    
    var body: some View {
        ZStack {
            LazyVStack {
                ForEach(viewModel.todoList, id: \.id) { todo in
                    Text(todo.todo)
                }
            }
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.fetchItems(uid: appUserInfo.appUser?.id ?? "")
                } catch {
                    print("Error fetching todos")
                }
            }
        }
    }
}

#Preview {
    ToDoView(viewModel: ToDoViewModel(), appUserInfo: .init())
}
