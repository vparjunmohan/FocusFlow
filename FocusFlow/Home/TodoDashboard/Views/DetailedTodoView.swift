//
//  DetailedTodoView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 15/09/24.
//

import SwiftUI

struct DetailedTodoView: View {
    
    var todo: Todos
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: AppSpacers.xlarge) {
                todoTitleField
                optionView
                todoDescription
            }
        }
        .padding(.horizontal, AppSpacers.large)
        .padding(.top, AppSpacers.large)
        .navigationTitle("Details")
        .background(AppColors.surfacePrimary.ignoresSafeArea())
    }
    
    private var todoTitleField: some View {
        TextField("", text: Binding(get: {
            todo.task
        }, set: { _ in
            
        }), axis: .vertical)
            .font(FontHelper.applyFont(forTextStyle: .title, weight: .bold))
            .foregroundStyle(AppColors.textPrimary)
    }
    
    private var dateView: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text("Created Date")
            
            Text("Due Date")
            
            Text("Priority")
        }
        .font(FontHelper.applyFont(forTextStyle: .callout, weight: .semiBold))
        .foregroundStyle(AppColors.textTertiary)
    }
    
    private var optionFillView: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text("15 September 2024")
            
            Text("20 September 2024")
            
            priorityView
        }
        .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
        .foregroundStyle(AppColors.textPrimary)
    }
    
    private var priorityView: some View {
        Text(Helpers.shared.getPriority(todo: todo))
            .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .bold))
            .foregroundStyle(.white)
            .padding(AppSpacers.xxsmall)
            .padding(.horizontal, AppSpacers.xxsmall)
            .background(
                RoundedRectangle(cornerRadius: AppSpacers.xsmall)
                    .fill(Helpers.shared.updateTaskPriority(todo: todo))
            )
    }
    
    private var optionView: some View {
        HStack(spacing: AppSpacers.medium) {
            dateView
            optionFillView
        }
    }
    
    private var todoDescription: some View {
        VStack(alignment: .leading, spacing: AppSpacers.medium) {
            Text("Description")
                .font(FontHelper.applyFont(forTextStyle: .callout, weight: .semiBold))
                .foregroundStyle(AppColors.textTertiary)
            TextField("", text: Binding(get: {
                todo.taskDescription
            }, set: { _ in
                
            }), axis: .vertical)
                .font(FontHelper.applyFont(forTextStyle: .body))
                .foregroundStyle(AppColors.textPrimary)
        }
    }
}

#Preview {
    DetailedTodoView(todo: .init(id: 1, createdAt: "20/8", task: "Go to gym", taskDescription: "some description", priority: "Priority 3", userUID: "qwyefuig", duedate: 123323))
}
