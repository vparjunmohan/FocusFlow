//
//  ContentView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SignInView()
            .onAppear {
                Task {
                    try await AuthManager.shared.getCurrentSession()
                }
            }
    }
}

#Preview {
    ContentView()
}
