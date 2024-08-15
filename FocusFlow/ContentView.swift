//
//  ContentView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var appUser: AppUser?
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Loading...")
            } else if let appUser = appUser {
                HomeView(appUser: appUser)
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .onAppear {
            Task {
                appUser = try await AuthManager.shared.getCurrentSession()
                isLoading = false
            }
        }
    }
}

#Preview {
    ContentView()
}
