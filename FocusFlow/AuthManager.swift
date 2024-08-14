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
    
    func signInWithApple(idToken: String, nonce: String) async throws {
        
        let session = try await client.auth.signInWithIdToken(credentials: .init(provider: .apple, idToken: idToken, nonce: nonce))
        print(session)
        print(session.user)
    }
    
    func getCurrentSession() async throws {
        let session = try await client.auth.session
        print(session)
    }
}
