//
//  OnboardingView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

/// A view that handles the onboarding process for the application.
///
/// This struct represents the onboarding screen, which introduces users to the app and provides
/// a way to sign in. It creates an instance of `AuthViewModel` as a `StateObject` to manage
/// authentication-related tasks throughout the onboarding flow.
///
/// - `authViewModel`: An instance of `AuthViewModel` that handles user authentication. It is
///   initialized as a `StateObject`, ensuring it is managed by SwiftUI and persists through
///   the view’s lifecycle.
struct OnboardingView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                ProgressView("Loading...")
            } else if let _ = authViewModel.appUser {
                MainTabView(authViewModel: authViewModel)
            } else {
                SignInView(authViewModel: authViewModel)
            }
        }
    }
}


#Preview {
    OnboardingView()
}
