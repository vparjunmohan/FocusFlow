//
//  SettingsView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

/// SettingsView is responsible for displaying user settings and account-related options.
struct SettingsView: View {
    /// Observes the AuthViewModel to respond to changes in authentication state, such as login or logout.
    @ObservedObject var authVM: AuthViewModel
    /// The main content view of the SettingsView, displaying user information and providing options to log out or delete the account.
    var body: some View {
        VStack {
            /// Displays the user's ID, or "no id" if it is unavailable.
            Text(authVM.appUser?.id ?? "no id")
            
            /// Displays the user's email, or "No email" if it is unavailable.
            Text(authVM.appUser?.email ?? "No email")
            
            /// Button that triggers the sign-out process when tapped.
            Button(action: {
                Task {
                    do {
                        /// Attempts to sign out the user asynchronously.
                        try await authVM.signOut()
                    } catch {
                        /// Logs an error message if sign-out fails.
                        print("Failed to log out")
                    }
                }
            }) {
                /// Styles the "Logout" button with padding, a red background, white text, and rounded corners.
                Text("Logout")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            /// Button that triggers the account deletion process when tapped.
            Button("Delete account") {
                Task {
                    do {
                        /// Attempts to delete the user's account asynchronously.
                        try await authVM.deleteAccount()
                    } catch {
                        /// Logs an error message if account deletion fails.
                        print("Failed to delete the user")
                    }
                }
            }
        }
    }

}

#Preview {
    SettingsView(authVM: .init())
}
