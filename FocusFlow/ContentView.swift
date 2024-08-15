//
//  ContentView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var appUser: AppUserInfo?
    @State private var isLoading: Bool = true
    
    var body: some View {
        ZStack {
            if isLoading {
                ProgressView("Loading...")
            } else if let appUser = appUser {
                HomeView(userInfo: appUser, appUserBinding: $appUser)
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .onAppear {
            if let appUser = AuthManager.shared.getCurrentSession() {
                self.appUser = appUser
            }
            isLoading = false
        }
    }
}


#Preview {
    ContentView()
}
