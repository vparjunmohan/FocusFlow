//
//  MainTabView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    @State private var tabBarHeight: CGFloat = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(authVM: authViewModel)
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            SettingsView(authVM: authViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(1)
        }
        .tint(AppColors.themeColor)
        .configureTabViewBackground(AppColors.cardColor)
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel())
}
