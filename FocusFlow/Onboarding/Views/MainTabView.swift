//
//  MainTabView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var reachability: Reachability
    @ObservedObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    @State private var tabBarHeight: CGFloat = 0
    
    var body: some View {
        ZStack {
            if reachability.isConnected {
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
                .transition(.opacity) // Transition for fading in/out
                .animation(.easeInOut(duration: 0.5), value: reachability.isConnected) // Animation for state change
            } else {
                    Color.black.ignoresSafeArea()
                    Text("You're offline")
                        .foregroundStyle(.white)
                        .font(.title)
                
                .transition(.opacity) // Transition for fading in/out
                .animation(.easeInOut(duration: 0.5), value: reachability.isConnected) // Animation for state change
            }
        }
        .animation(.easeInOut(duration: 0.5), value: reachability.isConnected) // Overall animation
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel())
        .environmentObject(Reachability())
}
