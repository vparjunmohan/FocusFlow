//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var signInViewModel = SignInViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button {
            Task {
                do {
                    let appleResult = try await signInViewModel.signInWithApple()
                    try await authViewModel.signIn(idToken: appleResult.idToken, nonce: appleResult.nonce)
                } catch {
                    print("Error signing in: \(error)")
                    
                }
            }
        } label: {
            Text("Sign in with Apple")
        }
    }
}

#Preview {
    SignInView(authViewModel: .init())
}
