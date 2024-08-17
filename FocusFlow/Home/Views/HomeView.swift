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
    @State var createTodoPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            
            ZStack(alignment: .bottomTrailing) {
                AppColors.appBgColor.ignoresSafeArea()
                ScrollView {
                    LazyVStack(spacing: 0) {
                        DayBriefCardView()
                            .padding(.top, AppSpacers.large)
                            .frame(height: 230)
                        // ToDoView(viewModel: todoVM, appUserInfo: authVM)
                    }
                }
                
                if createTodoPresented {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                        .transition(.opacity)
                        .animation(.easeInOut, value: createTodoPresented)
                }
                
                createTodoButton
                
                    .padding(.all, AppSpacers.xxxlarge)
                CreateTodoView(viewModel: todoVM, createTodoPresented: $createTodoPresented)
                    .padding(.top, 100)
                    .offset(y: createTodoPresented ? 0 : UIScreen.main.bounds.height)
                    .transition(.move(edge: .bottom))
                    .animation(.spring, value: createTodoPresented)
                    .environmentObject(authVM)
                
            }
            //            .navigationTitle("Today")
            //            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                NavigationLink {
                   
                } label: {
                    Image("navbarIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .padding(.trailing, AppSpacers.large)
                }
            })
        }
    }
    
    var createTodoButton: some View {
        Button {
            createTodoPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(AppColors.themeColor)
        }
    }
}

#Preview {
    HomeView(authVM: .init(), todoVM: .init())
}
