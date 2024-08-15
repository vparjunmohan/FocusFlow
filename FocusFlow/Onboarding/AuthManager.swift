//
//  AuthManager.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import Foundation
import Supabase

struct AppUser {
    let uid: String
    let email: String?
}

class AuthManager {
    
    static let shared = AuthManager()
    private init() {}
    
    let client = SupabaseClient(supabaseURL: URL(string: URLS.baseURL)!, supabaseKey: URLS.authKey)
    
    func signInWithApple(idToken: String, nonce: String) async throws -> AppUser {
        
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func getCurrentSession() -> AppUser? {
        // Get the current session without 'await' since it's not async
        guard let session = client.auth.currentSession else {
            return nil
        }
        
        // Return AppUser directly if session is available
        let user = session.user
        return AppUser(uid: user.id.uuidString, email: user.email)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
}
