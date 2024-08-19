//
//  HomeView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/08/24.
//

import SwiftUI

/// The main view for the Home screen of the app.
///
/// The `HomeView` manages and displays the core content of the app's home screen. It integrates
/// authentication, to-do management, and the creation of new to-do items. The view utilizes
/// state ``ToDoViewModel ``and observable ``AuthViewModel`` objects to maintain and update the UI based on the user's interactions.
struct HomeView: View {
    @ObservedObject var authVM: AuthViewModel
    @StateObject var todoVM = ToDoViewModel()
    @State var createTodoPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                backgroundView
                contentView
                createTodoButton
            }
            .sheet(isPresented: $createTodoPresented) {
                createTodoSheet
            }
        }
    }
    
    // MARK: - Subviews
    /// The sheet view for creating a new to-do item.
    ///
    /// This view presents the ``CreateTodoView`` in a sheet, allowing the user to add a new to-do item.
    /// The sheet is configured with a height of 200 points and includes a visible drag indicator,
    /// enabling users to drag the sheet to dismiss it. The ``authVM`` is passed as an environment object
    /// to provide necessary authentication data to the `CreateTodoView`. The state binding
    /// `createTodoPresented` controls the visibility of this sheet.
    var createTodoSheet: some View {
        CreateTodoView(viewModel: todoVM, createTodoPresented: $createTodoPresented)
            .environmentObject(authVM)
            .presentationDetents([.height(200)])
            .presentationDragIndicator(.visible)
    }
    
    /// The background view for the Home screen.
    ///
    /// This view applies the app's background color to the entire screen, extending
    /// beyond the safe area boundaries to ensure the background covers the entire
    /// visible area. This creates a seamless background that fills the screen,
    /// regardless of the device's status bar, notch, or other UI elements.
    var backgroundView: some View {
        AppColors.appBgColor
            .ignoresSafeArea()
    }
    
    /// The main content view of the Home screen.
    ///
    /// This view contains a scrollable vertical stack of content. It uses a `ScrollView`
    /// to allow for vertical scrolling when the content exceeds the screen's height.
    /// Inside the scroll view, a `LazyVStack` is used to efficiently manage the content,
    /// loading views lazily as they come into view. The stack currently contains the
    /// ``DayBriefCardView``, which is styled with top padding and a fixed height.
    ///
    /// Additional content, such as the ``ToDoView``, can be added to this stack to extend
    /// the functionality of the Home screen.
    var contentView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                DayBriefCardView()
                    .padding(.top, AppSpacers.large)
                    .frame(height: AppComponentSize.dayBriefCardHeight)
                 ToDoView(viewModel: todoVM, appUserInfo: authVM)
            }
        }
    }
    
    /// A button that triggers the presentation of the "Create To-Do" sheet.
    ///
    /// When tapped, this button toggles the `createTodoPresented` state variable,
    /// which in turn presents a sheet view for creating a new to-do item.
    /// The button is styled with a plus-circle icon, resized to the specified dimensions,
    /// and colored using the app's theme color. It is positioned at the bottom-right
    /// of the screen with ample padding around it.
    var createTodoButton: some View {
        Button {
            createTodoPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: AppIconSize.xxlarge, height: AppIconSize.xxlarge)
                .foregroundStyle(AppColors.themeColor)
                .background(
                    Circle()
                        .fill(AppColors.appBgColor)
                        .frame(width: AppIconSize.xxlarge, height: AppIconSize.xxlarge)
                )
        }
        .padding(.all, AppSpacers.xxxlarge)
    }
}

#Preview {
    HomeView(authVM: .init(), todoVM: .init())
}
