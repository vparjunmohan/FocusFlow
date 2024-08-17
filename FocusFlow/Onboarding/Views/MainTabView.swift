//
//  MainTabView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        TabView {
            HomeView(authVM: authViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
            SettingsView(authVM: authViewModel)
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
            .tag(1)
        }
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel())
}
