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
            Color.white.ignoresSafeArea()
            VStack {
                onboardingImage
                Spacer()
                titleView
                Spacer(minLength: 40)
                signInWithAppleButton
                    .padding(.horizontal, 22)
            }
            .padding(.vertical, 40)
        }
    }
    
    private var onboardingImage: some View {
        Image("onboardingImage")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
    
    private var titleView: some View {
        VStack(spacing: 10) {
            Text("Keep on track with Todo")
                .foregroundStyle(.black)
                .font(FontHelper.applyFont(forTextStyle: .title, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text("Make your task on track easily and seamlessly")
                .font(FontHelper.applyFont(forTextStyle: .body, weight: .regular))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal, 22)
    }
    
    private var signInWithAppleButton: some View {
        Button(action: signInWithApple) {
            ZStack {
                RoundedRectangle(cornerRadius: AppCornerCurves.large)
                    .foregroundColor(.black)
                    .frame(height: AppComponentSize.buttonHeight)
                
                HStack(spacing: 10) {
                    Image("appleLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: AppIconSize.medium, height: AppIconSize.medium)
                    
                    Text("Sign in with Apple")
                        .font(FontHelper.applyFont(forTextStyle: .title3, weight: .medium))
                        .foregroundStyle(.white)
                }
            }
        }
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
