//
//  AuthManager.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import Foundation
import Supabase

struct AppUser: Equatable {
    var uid: String
    var email: String?

    static func == (lhs: AppUser, rhs: AppUser) -> Bool {
        return lhs.uid == rhs.uid && lhs.email == rhs.email
    }
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
    
    func deleteUser(userId: String) async throws {
            let url = URL(string: "\(URLS.baseURL)/auth/v1/admin/users/\(userId)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            // Add both the service role key and the API key in the request headers
            request.addValue("Bearer \(URLS.serviceRoleKey)", forHTTPHeaderField: "Authorization")
            request.addValue(URLS.authKey, forHTTPHeaderField: "apikey")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    throw NSError()
                }
                try await client.auth.signOut()
                print("User deleted successfully")
            } else {
                throw NSError(domain: "Failed to delete user", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
            }
        }
}
