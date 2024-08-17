//
//  DayBriefCardView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

struct DayBriefCardView: View {
    @StateObject private var viewModel = DayBriefCardViewModel()
    
    var body: some View {
        HStack(spacing: 40) {
            dateColumn
            messageColumn
        }
        .padding([.horizontal, .vertical], AppSpacers.medium)
        .frame(maxWidth: .infinity, maxHeight: 200)
        .padding(.horizontal, AppSpacers.medium)
        .background(cardBackground)
    }
    
    private var dateColumn: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Today")
                .font(FontHelper.applyFont(forTextStyle: .title, weight: .medium))
            Spacer()
            Text(viewModel.currentWeekday)
                .font(FontHelper.applyFont(forTextStyle: .headline, weight: .regular))
                .foregroundStyle(.orange)
            Text(viewModel.currentDay)
                .font(FontHelper.applyFont(forTextStyle: .title, weight: .medium))
        }
        .padding(.leading, AppSpacers.small)
    }
    
    private var messageColumn: some View {
        VStack {
            Text("Progress begins with a single step. What will you do today to make your week count?")
                .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.top, AppSpacers.small)
        .padding(.trailing, AppSpacers.small)
    }
    
    private var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppCornerCurves.large)
            .fill(AppColors.cardColor)
            .padding(.horizontal, AppSpacers.large)
    }
}

#Preview {
    DayBriefCardView()
}
