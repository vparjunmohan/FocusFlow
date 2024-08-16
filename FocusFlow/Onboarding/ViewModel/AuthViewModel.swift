//
//  AuthViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var appUser: AppUserInfo?
    @Published var isLoading: Bool = true
    
    private let authManager = AuthManager.shared
    
    init() {
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        if let appUser = authManager.getCurrentSession() {
            DispatchQueue.main.async { [weak self] in
                self?.appUser = appUser
                self?.isLoading = false
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
            }
        }
    }
    
    func signIn(idToken: String, nonce: String) async throws {
        let newUser = try await authManager.signInWithApple(idToken: idToken, nonce: nonce)
        await MainActor.run {
            self.appUser = newUser
        }
    }
    
    func signOut() async throws {
        try await authManager.signOut()
        await MainActor.run {
            self.appUser = nil
        }
    }
    
    func deleteAccount() async throws {
        guard let userId = appUser?.id else { throw NSError(domain: "No user logged in", code: -1) }
        try await authManager.deleteUser(userId: userId)
        await MainActor.run {
            self.appUser = nil
        }
    }
}
