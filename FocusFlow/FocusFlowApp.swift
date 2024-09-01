//
//  FocusFlowApp.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

@main
struct FocusFlowApp: App {
    @StateObject private var reachability = Reachability()
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(reachability)
        }
    }
}
