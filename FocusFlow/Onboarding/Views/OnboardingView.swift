//
//  OnboardingView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isLoading {
                ProgressView("Loading...")
            } else if let _ = authViewModel.appUser {
                HomeView(authVM: authViewModel) // Ensure naming consistency
            } else {
                SignInView(authViewModel: authViewModel)
            }
        }
    }
}


#Preview {
    OnboardingView()
}
