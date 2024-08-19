//
//  SettingsView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var authVM: AuthViewModel
    var body: some View {
        VStack {
            Text(authVM.appUser?.id ?? "no id")
            Text(authVM.appUser?.email ?? "No email")
            Button(action: {
                Task {
                    do {
                        try await authVM.signOut()
                    } catch {
                        print("Failed to log out")
                    }
                }
            }) {
                Text("Logout")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button("Delete account") {
                Task {
                    do {
                        try await authVM.deleteAccount()
                    } catch {
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
