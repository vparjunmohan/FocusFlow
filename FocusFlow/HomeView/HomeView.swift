//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @State var appUser: AppUser
    @State private var isLoading: Bool = false
    @Binding var appUserBinding: AppUser?

    var body: some View {
        VStack(spacing: 15) {
            Text(appUser.uid)
            Text(appUser.email ?? "No email")
            
            Button(action: {
                Task {
                    do {
                        isLoading = true
                        try await AuthManager.shared.signOut()
                        appUserBinding = nil
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
                        try await AuthManager.shared.deleteUser(userId: appUser.uid)
                        appUserBinding = nil
                    } catch {
                        print("Failed to delete the user")
                    }
                }
            }
        }
        .onChange(of: appUserBinding) { newValue in
            if newValue == nil {
                // Navigate back to ContentView
                // This will be handled by setting appUserBinding to nil in ContentView
            }
        }
    }
}

#Preview {
    HomeView(appUser: .init(uid: "123", email: "test@gmail.com"), appUserBinding: .constant(.init(uid: "123", email: "test@gmail.com")))
}
