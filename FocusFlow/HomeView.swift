//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @State var appUser: AppUser
    var body: some View {
        VStack {
            Text(appUser.uid)
            Text(appUser.email ?? "No email")
        }
    }
}

#Preview {
    HomeView(appUser: .init(uid: "123", email: "test@gmail.com"))
}
