//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authVM: AuthViewModel
    @StateObject var todoVM = ToDoViewModel()
    @State private var isLoading: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text(authVM.appUser?.id ?? "")
                Text(authVM.appUser?.email ?? "No email")

                Button(action: {
                    Task {
                        do {
                            isLoading = true
                            try await authVM.signOut()
                        } catch {
                            print("Failed to log out")
                        }
                        isLoading = false
                    }
                }) {
                    Text("Logout")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(isLoading)

                Button("Delete account") {
                    Task {
                        do {
                            try await authVM.deleteAccount()
                        } catch {
                            print("Failed to delete the user")
                        }
                    }
                }

                ToDoView(viewModel: todoVM, appUserInfo: authVM)
            }
            .navigationTitle("ToDo")
            .toolbar(content: {
                NavigationLink {
                    CreateTodoView(viewModel: todoVM)
                        .environmentObject(authVM)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.all, 8)
                        .foregroundStyle(.purple)
                }
            })
        }
    }
}

#Preview {
    HomeView(authVM: .init(), todoVM: .init())
}
