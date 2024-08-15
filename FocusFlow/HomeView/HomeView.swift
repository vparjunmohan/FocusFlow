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
        VStack {
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
        }
    }
}

#Preview {
    HomeView(appUser: .init(uid: "123", email: "test@gmail.com"), appUserBinding: .constant(.init(uid: "123", email: "test@gmail.com")))
}
