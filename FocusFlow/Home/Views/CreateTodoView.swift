//
//  CreateTodoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 16/08/24.
//

import SwiftUI

struct CreateTodoView: View {
    @ObservedObject var viewModel: ToDoViewModel
    @EnvironmentObject var appUserViewModel: AuthViewModel
    @State var todoTitle = ""
    @Binding var createTodoPresented: Bool
    var textFieldPlaceholder: String = "e.g., Go to gym tomorrow at 6am"
    @State var textEditorPlaceholder: String = "Description"
    
    var body: some View {
        ZStack {
            AppColors.appBgColor.ignoresSafeArea()
            
            VStack {
                closeButton
                
                todoTitleField
                
                todoDescriptionEditor
                
                submitButton
                
                
            }
            .background(Color.teal)
        }
        .cornerRadius(10)
    }
    
    // MARK: - Components
    
    private var todoTitleField: some View {
        TextField(textFieldPlaceholder, text: $todoTitle)
            .font(FontHelper.applyFont(forTextStyle: .headline, weight: .medium))
            .padding(.horizontal, AppSpacers.large)
    }
    
    private var todoDescriptionEditor: some View {
        TextEditor(text: $textEditorPlaceholder)
            .font(FontHelper.applyFont(forTextStyle: .body, weight: .regular))
            .colorMultiply(AppColors.appBgColor)
            .padding(.horizontal, AppSpacers.large)
            .frame(height: 70)
    }
    
    private var submitButton: some View {
        HStack {
            Spacer()
            Button(action: submitTodo, label: {
                ZStack {
                    Circle()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(AppColors.themeColor)
                    Image(systemName: "arrow.up")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.white)
                }
            })
            .padding(.horizontal, AppSpacers.large)
        }
    }
    
    // MARK: - Actions
    
    private func submitTodo() {
        Task {
            do {
                try await viewModel.createItem(text: todoTitle, userUID: appUserViewModel.appUser?.id ?? "")
                createTodoPresented.toggle()
            } catch {
                print("Failed to create todo")
            }
        }
    }
    
    var closeButton: some View {
        HStack {
            Spacer()
            Button {
                createTodoPresented.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundStyle(AppColors.dangerColor)
            }
        }
        .padding(.all, AppSpacers.large)
    }
}


#Preview {
    CreateTodoView(viewModel: ToDoViewModel(), createTodoPresented: .constant(false))
        .environmentObject(AuthViewModel()) // Inject the environment object for appUserViewModel
}
