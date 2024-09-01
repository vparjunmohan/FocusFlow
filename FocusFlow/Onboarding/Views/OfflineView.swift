//
//  OfflineView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 01/09/24.
//

import SwiftUI
import Lottie

/// A view displayed when the app is offline.
///
/// The `OfflineView` provides a visual indicator to users that they are offline. It consists of a full-screen
/// black background with a `LottieView` animation to indicate the offline status. The animation is centered
/// and has a fixed size of 300x300 points. The use of `ZStack` ensures that the background color covers the
/// entire screen, while the `VStack` centers the animation vertically with a specified spacing.
///
/// - Note: The `LottieView` uses an animation file named "OfflineAnimation". Ensure this file is included
///         in the project resources.
struct OfflineView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 20) {
                LottieView(filename: "OfflineAnimation")
                    .background(Color.black)
                    .frame(width: 300, height: 300)
            }
        }
    }
}

#Preview {
    OfflineView()
}
