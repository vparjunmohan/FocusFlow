//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var authVM: AuthViewModel
    @StateObject var todoVM = ToDoViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    DayBriefCardView()
                        .padding(.top, AppSpacers.large)
                        .frame(height: 230)
                    
                
                    //                    ToDoView(viewModel: todoVM, appUserInfo: authVM)
                }
            }
            
            .navigationTitle("ToDo")
            .toolbar(content: {
                NavigationLink {
                    CreateTodoView(viewModel: todoVM)
                        .environmentObject(authVM)
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.all, 8)
                        .foregroundStyle(.purple)
                }
            })
        }
    }
}

#Preview {
    HomeView(authVM: .init(), todoVM: .init())
}
