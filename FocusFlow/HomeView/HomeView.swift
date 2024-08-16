//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(spacing: 15) {
            Text(authViewModel.appUser?.id ?? "")
            Text(authViewModel.appUser?.email ?? "No email")
            
            Button(action: {
                Task {
                    do {
                        isLoading = true
                        try await authViewModel.signOut()
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
                        try await authViewModel.deleteAccount()
                    } catch {
                        print("Failed to delete the user")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(authViewModel: .init())
}
