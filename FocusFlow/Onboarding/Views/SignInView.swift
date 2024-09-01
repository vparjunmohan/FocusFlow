//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

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
    
    private var onboardingImage: some View {
        Image(.onboarding)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 300)
    }
    
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
    
    private var termsAndConditions: some View {
        Text(termsAndConditionsAttributedString)
            .font(FontHelper.applyFont(forTextStyle: .footnote))
            .foregroundStyle(AppColors.textTertiary)
            .multilineTextAlignment(.center)
    }
    
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
