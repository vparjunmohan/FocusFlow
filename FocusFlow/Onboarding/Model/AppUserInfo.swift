//
//  AppUserInfo.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

//MARK: - AppUserInfo
/// A model representing user information within the app.
///
/// The `AppUserInfo` struct conforms to the `Identifiable` protocol, making it suitable for use in SwiftUI views
/// where a unique identifier is required. It encapsulates essential user-related data, including:
/// - `id`: A unique identifier for the user.
/// - `email`: The user's email address, which is optional.
/// - `aud`: The audience claim (optional), typically used to identify the intended audience of the JWT token.
/// - `role`: The role assigned to the user (optional), which can be used to manage user permissions.
/// - `emailConfirmedAt`: The timestamp indicating when the user's email was confirmed (optional).
/// - `phone`: The user's phone number (optional).
/// - `lastSignInAt`: The timestamp of the user's last sign-in (optional).
///
/// The initializer allows for creating an `AppUserInfo` instance with various combinations of these properties,
/// where `aud`, `role`, `emailConfirmedAt`, `phone`, and `lastSignInAt` are optional and can be omitted.
struct AppUserInfo: Identifiable {
    let id: String
    let email: String?
    let aud, role: String?
    let emailConfirmedAt, phone, lastSignInAt: String?
    
    init(id: String, aud: String? = nil, role: String? = nil, email: String?, emailConfirmedAt: String? = nil, phone: String? = nil, lastSignInAt: String? = nil) {
        self.id = id
        self.aud = aud
        self.role = role
        self.email = email
        self.emailConfirmedAt = emailConfirmedAt
        self.phone = phone
        self.lastSignInAt = lastSignInAt
    }
}
