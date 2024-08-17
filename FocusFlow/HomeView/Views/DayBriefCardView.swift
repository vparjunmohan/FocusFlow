//
//  DayBriefCardView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import SwiftUI

/// A view that displays a brief overview of tasks for the current day.
///
/// This view is designed to present:
/// - A column showing the current date and day of the week with specific formatting.
/// - A column with a motivational message related to daily progress.
///
/// The layout includes two columns arranged horizontally, with distinct background colors:
/// - A `dateColumn` on the left showing the current weekday and day.
/// - A `messageColumn` on the right with a message encouraging task management.
///
/// The overall card has rounded corners and specific padding for visual appeal.
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
    
    /// A vertical stack (VStack) that displays the date information for the card.
    ///
    /// This view includes:
    /// - A "Today" label with a medium weight title font.
    /// - The current weekday with an orange color, using a headline font.
    /// - The current day with a medium weight title font.
    ///
    /// The `VStack` is aligned to the leading edge and has no spacing between its elements.
    /// The entire stack has padding on the leading edge to separate it from adjacent content.
    var dateColumn: some View {
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
    
    /// A vertical stack (VStack) that displays a motivational message in the card.
    ///
    /// This view includes:
    /// - A `Text` view with a motivational message, formatted using a regular weight subheadline font and aligned to the leading edge.
    /// - A `Spacer` to push the content to the top of the `VStack`.
    ///
    /// The `VStack` has padding at the top and trailing edges to provide spacing from adjacent content and the edges of the parent view.
    var messageColumn: some View {
        VStack {
            Text("Progress begins with a single step. What will you do today to make your week count?")
                .font(FontHelper.applyFont(forTextStyle: .subheadline, weight: .regular))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.top, AppSpacers.small)
        .padding(.trailing, AppSpacers.small)
    }
    
    /// The background for the card, styled with a rounded rectangle.
    ///
    /// This view includes:
    /// - A `RoundedRectangle` with a corner radius defined by `AppCornerCurves.large` to create rounded corners.
    /// - The rectangle is filled with a color defined by `AppColors.cardColor`.
    /// - Padding is applied horizontally using `AppSpacers.large` to provide spacing between the card and adjacent content.
    ///
    /// This background provides a visually appealing container for the content of the card.
    var cardBackground: some View {
        RoundedRectangle(cornerRadius: AppCornerCurves.large)
            .fill(AppColors.cardColor)
            .padding(.horizontal, AppSpacers.large)
    }
}

#Preview {
    DayBriefCardView()
}
