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
    private var createTodoSheet: some View {
        CreateTodoView(todoViewModel: todoVM, createTodoPresented: $createTodoPresented)
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
    private var backgroundView: some View {
        AppColors.surfacePrimary
            .ignoresSafeArea()
    }
    
    /// The main content view of the Home screen.
    ///
    /// This view contains a scrollable vertical stack of content, allowing for a smooth user experience
    /// when the content exceeds the screen's height. It consists of two main components:
    ///
    /// 1. DayBriefCardView: Provides a summary of the day's activities or schedule.
    ///    - Styled with top padding for visual separation.
    ///    - Has a fixed height for consistency across devices.
    ///
    /// 2. ToDoView: Displays the user's to-do list or task management interface.
    ///    - Integrated with ToDoViewModel for task data management.
    ///    - Uses AuthViewModel for user authentication and personalization.
    ///
    /// This structure provides a flexible foundation for the Home screen, allowing for easy
    /// expansion with additional components or features in the future.
    private var contentView: some View {
        ScrollView {
            DayBriefCardView()
                .padding(.top, AppSpacers.large)
                .frame(height: AppComponentSize.dayBriefCardHeight)
             ToDoView(viewModel: todoVM, appUserInfo: authVM)
        }
    }
    
    /// A button that triggers the presentation of the "Create To-Do" sheet.
    ///
    /// When tapped, this button toggles the `createTodoPresented` state variable,
    /// which in turn presents a sheet view for creating a new to-do item.
    /// The button is styled with a plus-circle icon, resized to the specified dimensions,
    /// and colored using the app's theme color. It is positioned at the bottom-right
    /// of the screen with ample padding around it.
    private var createTodoButton: some View {
        Button {
            createTodoPresented.toggle()
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: AppIconSize.xxlarge, height: AppIconSize.xxlarge)
                .foregroundStyle(AppColors.themeColor)
                .background(
                    Circle()
                        .fill(AppColors.surfacePrimary)
                        .frame(width: AppIconSize.xxlarge, height: AppIconSize.xxlarge)
                )
        }
        .padding(.all, AppSpacers.xxxlarge)
    }
}

#Preview {
    HomeView(authVM: .init(), todoVM: .init())
}
