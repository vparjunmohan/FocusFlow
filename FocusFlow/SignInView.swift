//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func signInWithApple() async throws -> AppUser {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
}

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    @Binding var appUser: AppUser?
    
    var body: some View {
        Button {
            Task {
                do {
                    let appUser = try await viewModel.signInWithApple()
                    self.appUser = appUser
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
    SignInView(appUser: .constant(.init(uid: "123", email: "test@gmail.com")))
}
