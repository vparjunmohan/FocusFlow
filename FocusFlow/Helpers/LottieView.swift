//
//  LottieView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 01/09/24.
//

import SwiftUI
import Lottie

/// A SwiftUI view that integrates a Lottie animation.
///
/// `LottieView` is a `UIViewRepresentable` implementation that allows the use of Lottie animations in SwiftUI views.
/// It initializes a `LottieAnimationView` with a specified animation file and configures it to loop according
/// to the provided `loopMode`. The animation view is added as a subview of a container `UIView` and constrained
/// to fill the entire container.
///
/// - Parameters:
///   - filename: The name of the Lottie animation file to be displayed. This file must be included in the project resources.
///   - loopMode: The looping behavior of the animation. Defaults to `.loop`, which means the animation will repeat indefinitely.
///
/// - Methods:
///   - `makeUIView(context:)`: Creates and configures the `UIView` that contains the `LottieAnimationView`. The animation view is
///     added to the view and constrained to fill its bounds. The animation is then started with `play()`.
///   - `updateUIView(_:context:)`: Updates the `UIView` if needed. This method is currently empty but can be used to
///     handle changes to the view or animation properties.
struct LottieView: UIViewRepresentable {
    var filename: String
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: filename)
        animationView.loopMode = loopMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        animationView.play()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the UIView if needed
    }
}
