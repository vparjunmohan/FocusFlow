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
                HomeView(appUser: appUser, appUserBinding: $appUser)
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .onAppear {
            Task {
                if let appUser = try? await AuthManager.shared.getCurrentSession() {
                    self.appUser = appUser
                }
                isLoading = false
            }
        }
        .onChange(of: appUser) { newValue in
            if newValue == nil {
                // Reset the view or perform any additional cleanup
            }
        }
    }
}


#Preview {
    ContentView()
}
