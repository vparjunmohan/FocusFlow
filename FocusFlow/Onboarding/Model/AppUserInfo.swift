//
//  AppUserInfo.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import Foundation

struct AppUserInfo {
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
