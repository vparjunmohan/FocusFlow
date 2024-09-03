//
//  MainTabView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

/// A SwiftUI view that displays a tab-based interface with different content based on network connectivity.
///
/// `MainTabView` shows a `TabView` containing `HomeView` and `SettingsView` when the network is connected,
/// and displays an `OfflineView` when the network is offline. The transition between these states is animated
/// with a fade effect to enhance the user experience.
///
/// - Properties:
///   - `reachability`: An environment object that provides network connectivity status. The view observes this
///     object to determine whether the network is connected or offline.
///   - `authViewModel`: An observed object that provides authentication-related data and actions for the views.
///   - `selectedTab`: A state variable to keep track of the currently selected tab in the `TabView`.
///
/// - Body:
///   - The view displays a `ZStack` to overlay the content based on network connectivity. If the network is
///     connected (`reachability.isConnected` is `true`), it shows the `connectedView` containing the `TabView`.
///     Otherwise, it shows the `OfflineView`. The transition between these views is animated with a fade effect.
///     The animation duration is set to 0.5 seconds and uses the `easeInOut` timing curve.
///
/// - Private Properties:
///   - `connectedView`: A computed property that returns the `TabView` containing `HomeView` and `SettingsView`.
///     The `TabView` allows users to switch between these views using tabs. The selected tab is highlighted with
///     the appropriate system image.
struct MainTabView: View {
    @EnvironmentObject var reachability: Reachability
    @ObservedObject var authViewModel: AuthViewModel
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Group {
                if reachability.isConnected {
                    connectedView
                } else {
                    OfflineView()
                }
            }
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.5), value: reachability.isConnected)
        }
    }
    
    // MARK: - Subviews
    /// The view displayed when there is an active network connection.
    ///
    /// This view provides a tabbed interface using `TabView`, allowing users to switch between different
    /// sections of the app, such as Home and Settings.
    ///
    /// - `TabView` manages the selection of tabs using the `selectedTab` state variable.
    /// - The `HomeView` and `SettingsView` are provided as tabs, each represented with a label and an
    ///   icon that visually indicates the currently selected tab.
    /// - The `Label` for each tab uses conditional logic to show a filled or outlined icon based on the
    ///   current `selectedTab` index.
    /// - `AppColors.themeColor` is applied as the tint color for the tab bar items, ensuring consistency
    ///   with the app's theme.
    /// - `configureTabViewBackground` is used to set the background color of the `TabView` to `AppColors.surfacePrimary`,
    ///   providing a unified look and feel across the app.
    private var connectedView: some View {
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
        .configureTabViewBackground(AppColors.surfacePrimary)
    }
}

#Preview {
    MainTabView(authViewModel: AuthViewModel())
        .environmentObject(Reachability())
}
