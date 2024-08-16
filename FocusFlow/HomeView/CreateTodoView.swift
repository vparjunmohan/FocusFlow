//
//  CreateTodoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI

struct CreateTodoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ToDoViewModel
    @EnvironmentObject var appUserViewModel: AuthViewModel
    @State var todoTitle = ""

    var body: some View {
        VStack(spacing: 15) {
            Text("Create a To Do")
                .font(.title)
                .bold()
                .padding(.top, 20)

            TextField("Enter your task", text: $todoTitle)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray, lineWidth: 1.0)
                )
                .padding()

            Button(action: {
                Task {
                    do {
                        try await viewModel.createItem(text: todoTitle, userUID: appUserViewModel.appUser?.id ?? "")
                        dismiss()
                    } catch {
                        print("Failed to create todo")
                    }
                }
            }, label: {
                Text("Create")
            })

            Spacer()
        }
    }
}


#Preview {
    CreateTodoView(viewModel: ToDoViewModel())
        .environmentObject(AuthViewModel()) // Inject the environment object for appUserViewModel
}
