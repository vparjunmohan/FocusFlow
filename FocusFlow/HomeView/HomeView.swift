//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @State var userInfo: AppUserInfo
    @State private var isLoading: Bool = false
    @Binding var appUserBinding: AppUserInfo?

    var body: some View {
        VStack(spacing: 15) {
            Text(userInfo.id)
            Text(userInfo.email ?? "No email")
            
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
                        try await AuthManager.shared.deleteUser(userId: userInfo.id)
                        appUserBinding = nil
                    } catch {
                        print("Failed to delete the user")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView(userInfo: .init(id: "123", email: "test@gmail.com"), appUserBinding: .constant(.init(id: "123", email: "test@gmail.com")))
}
