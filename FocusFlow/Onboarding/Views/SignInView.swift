//
//  SignInView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 14/08/24.
//

import SwiftUI

struct SignInView: View {
    
    @StateObject var viewModel = SignInViewModel()
    @Binding var appUser: AppUserInfo?
    
    var body: some View {
        Button {
            Task {
                do {
                    let appUser = try await viewModel.signInWithApple()
                    self.appUser = appUser
                } catch {
                    print("Error")
                }
            }
        } label: {
            Text("Sign in with Apple")
        }
    }
}

#Preview {
    SignInView(appUser: .constant(.init(id: "123", email: "test@gmail.com")))
}
