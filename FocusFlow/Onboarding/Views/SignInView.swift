//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

/// A view for the sign-in screen where users can authenticate their accounts.
///
/// This view presents the user interface for signing in, including fields for user input and buttons for authentication.
/// It uses a `SignInViewModel` to manage the sign-in logic and an `AuthViewModel` to handle authentication state and user data.
///
/// - `viewModel`: An instance of `SignInViewModel` that manages the state and logic specific to the sign-in process.
/// - `authViewModel`: An instance of `AuthViewModel` that handles the overall authentication state and user information.
struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            AppColors.surfacePrimary.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: AppSpacers.xlarge) {
                
                headerView
                    .padding(AppSpacers.xlarge)
                
                onboardingImage
                
                titleView
                
                Spacer()
                
                signInWithAppleButton
                
                termsAndConditions
            }
            .padding(AppSpacers.xlarge)
        }
    }
    
    // MARK: - Subviews
    /// A view representing the header section of the sign-in screen.
    ///
    /// This view contains a horizontal stack (`HStack`) with:
    /// - A `Spacer` to push content to the center.
    /// - An image of the app logo, resized and clipped into a rounded rectangle shape.
    /// - A text label displaying the app name "Focus flow", styled with a bold title font and the app's theme color.
    /// - Another `Spacer` to ensure the content is centered within the `HStack`.
    private var headerView: some View {
        HStack(alignment: .center, spacing: AppSpacers.medium) {
            Spacer()
            Image(.appLogo)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.xsmall))
            Text("Focus flow")
                .font(FontHelper.applyFont(forTextStyle: .title, weight: .bold))
                .foregroundStyle(.appTheme)
            Spacer()
        }
    }
    
    /// A view displaying an onboarding image.
    ///
    /// This view presents an image related to the onboarding process, resized and set to fill its frame,
    /// providing a visual element that aligns with the app's onboarding theme.
    private var onboardingImage: some View {
        Image(.onboarding)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
    }
    
    /// A view containing the title and subtitle for the sign-in screen.
    ///
    /// This view arranges two text elements vertically (`VStack`):
    /// - A bold, centered title with the text "Stay on track, stay ahead", styled with a primary text color.
    /// - A subtitle with the text "Manage your tasks effortlessly, every single day", styled with a regular body font and a tertiary text color.
    private var titleView: some View {
        VStack(spacing: 20) {
            Text("Stay on track, stay ahead")
                .foregroundColor(AppColors.textPrimary)
                .font(FontHelper.applyFont(forTextStyle: .title2, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text("Manage your tasks effortlessly, every single day")
                .font(FontHelper.applyFont(forTextStyle: .body, weight: .regular))
                .foregroundColor(.textTertiary)
                .multilineTextAlignment(.center)
        }
    }
    
    /// A button that allows users to sign in with Apple.
    ///
    /// This button is styled with:
    /// - A rounded rectangle background in the primary text color.
    /// - An `HStack` containing:
    ///   - An Apple logo image rendered in the template mode, resized and styled with the surface primary color.
    ///   - A text label "Sign in with Apple" in a bold headline font and surface primary color.
    /// The button triggers the `signInWithApple` function when tapped.
    private var signInWithAppleButton: some View {
        Button(action: signInWithApple) {
            ZStack {
                RoundedRectangle(cornerRadius: AppCornerCurves.large)
                    .foregroundColor(AppColors.textPrimary)
                    .frame(height: AppComponentSize.buttonHeight)
                
                HStack(spacing: 10) {
                    Image("appleLogo")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: AppIconSize.large, height: AppIconSize.large)
                        .foregroundStyle(AppColors.surfacePrimary)
                    
                    Text("Sign in with Apple")
                        .font(FontHelper.applyFont(forTextStyle: .headline, weight: .bold))
                        .foregroundStyle(AppColors.surfacePrimary)
                }
            }
        }
    }
    
    /// A view displaying the terms and conditions statement.
    ///
    /// This text view uses an attributed string to underline "Terms of Service" and "Privacy Policy",
    /// providing clear links for users to access these documents. The text is styled with a footnote font
    /// and a tertiary color, centered within the view.
    private var termsAndConditions: some View {
        Text(termsAndConditionsAttributedString)
            .font(FontHelper.applyFont(forTextStyle: .footnote))
            .foregroundStyle(AppColors.textTertiary)
            .multilineTextAlignment(.center)
    }
    
    /// An attributed string for the terms and conditions statement.
    ///
    /// This computed property creates an `AttributedString` with underlined text for "Terms of Service" and
    /// "Privacy Policy" to highlight these sections. The underlined styles provide a visual cue for users
    /// to read or interact with these terms.
    private var termsAndConditionsAttributedString: AttributedString {
        var attributedString = AttributedString("By continuing you agree to Focus flow's Terms of Service and Privacy Policy")
        
        if let termsRange = attributedString.range(of: "Terms of Service") {
            attributedString[termsRange].underlineStyle = .single
        }
        
        if let privacyRange = attributedString.range(of: "Privacy Policy") {
            attributedString[privacyRange].underlineStyle = .single
        }
        
        return attributedString
    }
    
    // MARK: - Actions
    /// Initiates the sign-in process with Apple.
    ///
    /// This function asynchronously performs the sign-in operation using the `viewModel`'s `signInWithApple` method.
    /// If successful, it then uses the `authViewModel` to sign in with the Apple result's ID token and nonce.
    /// Errors during the sign-in process are printed to the console.
    private func signInWithApple() {
        Task {
            do {
                let appleResult = try await viewModel.signInWithApple()
                try await authViewModel.signIn(idToken: appleResult.idToken, nonce: appleResult.nonce)
            } catch {
                print("Error signing in: \(error)")
            }
        }
    }
}


#Preview {
    SignInView(authViewModel: .init())
}
