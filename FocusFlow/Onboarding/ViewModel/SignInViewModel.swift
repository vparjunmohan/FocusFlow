//
//  SignInViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import Foundation

class SignInViewModel: ObservableObject {
    
    let signInApple = SignInApple()
    
    func signInWithApple() async throws -> SignInAppleResult {
        return try await signInApple.startSignInWithAppleFlow()
    }
}
