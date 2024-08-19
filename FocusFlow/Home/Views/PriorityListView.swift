//
//  PriorityListView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 19/08/24.
//

import SwiftUI

/// A view that displays a list of priorities.
///
/// This view presents a vertical list of priority items, each with an icon and name.
/// The list uses a custom ``PriorityModel`` to define the items and their associated colors.
/// Each priority is displayed in a horizontal stack with a separator line between items,
/// except for the last item.
///
/// - `priorities`: An array of `PriorityModel` instances representing the list of priorities
///   to be displayed. This property is private to ensure it is only used within the ``PriorityListView``.
struct PriorityListView: View {
    
    private let priorities = PriorityModel.allPriorities
    
    /// The view's body, which defines the layout and appearance of the priority list.
    ///
    /// This view uses a vertical stack (`VStack`) to display a list of priority items. Each item is
    /// represented by a horizontal stack (`HStack`) containing an icon and a label. The list is
    /// generated using a `ForEach` loop with the priorities array, where each item is processed by
    /// the ``priorityRow(for:isLast:)`` function to determine if a separator should be included.
    ///
    /// - The `VStack` is aligned to the leading edge and provides padding around the vertical axis.
    /// - The background color of the stack is set to `AppColors.cardColor` with rounded corners.
    /// - Additional padding is applied around the entire view to ensure spacing from its container.
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(priorities.enumerated()), id: \.element) { index, priority in
                priorityRow(for: priority, isLast: index == priorities.count - 1)
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width / 1.25)
        .background(AppColors.cardColor)
        .clipShape(RoundedRectangle(cornerRadius: AppCornerCurves.xsmall))
        .shadow(color: .black.opacity(0.2), radius: 3, y: 5.0)
        .padding(AppSpacers.large)
    }
    
    /// A view builder function that creates a row for displaying a priority item.
    ///
    /// This function generates a horizontal stack (`HStack`) that includes the priority icon
    /// and the priority information. It also determines if a separator should be shown based on
    /// whether the priority item is the last in the list.
    ///
    /// - Parameters:
    ///   - priority: The `PriorityModel` instance containing the details of the priority item.
    ///   - isLast: A boolean indicating if this is the last priority item in the list.
    ///
    /// - Returns: A view containing the priority icon and information, with an optional separator.
    @ViewBuilder
    func priorityRow(for priority: PriorityModel, isLast: Bool) -> some View {
        HStack {
            priorityIcon(for: priority)
            priorityInfo(for: priority, showSeparator: !isLast)
        }
    }
    
    /// A view that displays the icon associated with a priority item.
    ///
    /// This function returns an `Image` view representing a flag icon, styled with the color
    /// associated with the given priority item. The icon is padded horizontally for spacing.
    ///
    /// - Parameters:
    ///   - priority: The ``PriorityModel`` instance containing the details of the priority item.
    ///
    /// - Returns: An `Image` view styled with the priority color.
    func priorityIcon(for priority: PriorityModel) -> some View {
        Image(systemName: "flag.fill")
            .padding(.horizontal, AppSpacers.medium)
            .foregroundStyle(priority.priorityColor)
    }
    
    /// A view that displays the information for a priority item, with an optional separator.
    ///
    /// This function returns a vertical stack (`VStack`) containing the priority name and an
    /// optional separator. The separator is shown based on the `showSeparator` parameter,
    /// which determines if the current item is not the last in the list.
    ///
    /// - Parameters:
    ///   - priority: The ``PriorityModel`` instance containing the details of the priority item.
    ///   - showSeparator: A boolean indicating if a separator should be displayed.
    ///
    /// - Returns: A `VStack` containing the priority name and, optionally, a separator.
    func priorityInfo(for priority: PriorityModel, showSeparator: Bool) -> some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(priority.name)
                .font(FontHelper.applyFont(forTextStyle: .subheadline))
                .padding(AppSpacers.small)
            
            if showSeparator {
                separator
            }
        }
    }
    
    /// A view representing a separator between priority items.
    ///
    /// This property returns a `Rectangle` view styled as a separator. The rectangle is filled
    /// with a gray color with reduced opacity and has a fixed height and full width.
    ///
    /// - Returns: A `Rectangle` view styled as a separator.
    var separator: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(maxWidth: .infinity)
            .frame(height: AppSpacers.unity)
    }
}

#Preview {
    PriorityListView()
}
