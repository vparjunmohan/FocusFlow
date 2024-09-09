//
//  ShimmerEffect.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 03/09/24.
//

import SwiftUI
/// A custom view that creates a shimmer effect using a linear gradient.
///
/// The `ShimmerEffect` struct provides a visually appealing shimmer effect, typically used to indicate
/// loading or placeholder content. The shimmer is created by animating a linear gradient across the view.
///
/// Properties:
/// - `gradientColors`: An array of colors used in the gradient. The colors are based on system gray colors to create a subtle shimmer.
/// - `startPoint`: The initial starting point of the gradient, defined as a `UnitPoint`.
/// - `endPoint`: The initial ending point of the gradient, defined as a `UnitPoint`.
///
/// The view's body consists of a `LinearGradient` that animates from `startPoint` to `endPoint` using
/// a repeating, non-reversing animation. The animation starts when the view appears on screen, giving
/// a continuous shimmering effect.
struct ShimmerEffect: View {
    private var gradientColors = [
        Color(uiColor: UIColor.systemGray3),
        Color(uiColor: UIColor.systemGray5),
        Color(uiColor: UIColor.systemGray3)
    ]
    @State var startPoint: UnitPoint = .init(x: -1.8, y: -1.2)
    @State var endPoint: UnitPoint = .init(x: 0, y: -0.2)
    var body: some View {
        LinearGradient (colors: gradientColors,
                        startPoint: startPoint,
                        endPoint: endPoint)
        .onAppear {
            withAnimation (.easeInOut (duration: 1)
                .repeatForever (autoreverses: false)) {
                    startPoint = .init(x: 1, y: 1)
                    endPoint = .init(x: 2.2, y: 2.2)
                }
        }
    }
}

//MARK: - SHIMMER VIEWS
/// A view that represents a loading placeholder for a single task item.
///
/// `TaskViewShimmer` mimics the structure and layout of the actual `TaskView`,
/// providing a seamless visual transition when the real content loads.
///
/// Key features:
/// - Uses ``ShimmerEffect`` to create an animated loading appearance.
/// - Matches the dimensions and layout of the actual task view for consistency.
/// - Adopts system-wide spacing and sizing constants for maintainability.
///
/// Structure:
/// - An `HStack` containing:
///   1. A circular shimmer effect (left), representing a potential task icon or checkbox.
///   2. A `VStack` (right) with two shimmer effects, representing the task title and additional details.
///
/// The overall view is styled to match the app's visual design, including background color and corner radius.
struct TaskViewShimmer: View {
    var body: some View {
        HStack(spacing: AppSpacers.large) {
            // Left side: Circular shimmer effect (e.g., for a task icon or checkbox)
            ShimmerEffect()
                .frame(width: AppIconSize.medium, height: AppIconSize.medium)
                .clipShape(Circle())
            
            // Right side: Task details
            VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
                // Top shimmer: Represents the task title
                ShimmerEffect()
                    .frame(maxWidth: .infinity)
                    .frame(height: 20)
                
                // Bottom shimmer: Represents additional task details or metadata
                HStack(spacing: AppSpacers.medium) {
                    ShimmerEffect()
                        .frame(width: 150, height: 20)
                }
            }
        }
        .padding(.all, AppSpacers.large)
        .frame(height: AppComponentSize.taskViewHeight)
        .background(AppColors.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.small))
    }
}

#Preview {
    TaskViewShimmer()
}
