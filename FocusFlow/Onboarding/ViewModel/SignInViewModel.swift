//
//  SignInViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func signInWithApple() async throws -> AppUserInfo {
        let appleResult = try await signInApple.startSignInWithAppleFlow()
        return try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
    }
}
