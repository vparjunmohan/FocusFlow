//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func signInWithApple() async throws {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
}

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
   
    
    var body: some View {
        Button {
            Task {
                do {
                    try await viewModel.signInWithApple()
                } catch {
                    print("Error")
                }
            }
        } label: {
            Text("Sign in with Apple")
        }
    }
}

#Preview {
    SignInView()
}
