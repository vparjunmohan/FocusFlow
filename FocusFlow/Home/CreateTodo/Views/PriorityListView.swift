//
//  PriorityListView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 19/08/24.
//

import SwiftUI

/// A view that displays a list of priorities for selection.
///
/// This view presents a vertical list of priority items, each represented with an icon and name.
/// The list is based on a custom ``PriorityModel`` that defines the priorities and their associated colors.
/// Each priority is displayed in a horizontal stack with a separator line between items, except for the last item.
///
/// - `selectedPriority`: A binding to the currently selected priority, allowing the parent view to be updated.
/// - `showPicker`: A binding that controls the visibility of the priority picker.
/// - `priorities`: A private array of `PriorityModel` instances representing the list of priorities to be displayed.
struct PriorityListView: View {
    @Binding var selectedPriority: PriorityModel
    @Binding var showPicker: Bool
    private let priorities = PriorityModel.allPriorities
    
    /// The main content of the `PriorityListView`, defining the layout and appearance of the priority list.
    ///
    /// The `body` uses a vertical stack (`VStack`) to organize a list of priority items. Each item is displayed using a horizontal stack (`HStack`) which includes an icon and a label. The list is created by iterating over the `priorities` array with a `ForEach` loop, and each row is constructed using the `priorityRow(for:isLast:)` function. This function determines whether a separator should be included based on the position of the item in the list.
    ///
    /// - The `VStack` is aligned to the leading edge and contains padding for spacing around the vertical axis.
    /// - The background color is set to `AppColors.cardColor`, and the view is enclosed in a rounded rectangle with a shadow effect for visual enhancement.
    /// - The view's width is constrained to a portion of the screen width, and it includes padding around the entire view to ensure proper spacing from its container.
    /// - Tapping on a priority item updates the `selectedPriority` and toggles the `showPicker` to dismiss the picker view, using an animation defined in the `priorityRow` function.
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
    
    // MARK: - Subviews
    /// A view builder function that creates a row for displaying a priority item.
    ///
    /// This function generates a horizontal stack (`HStack`) that includes the priority icon
    /// and the priority information. It also determines if a separator should be shown based on
    /// whether the priority item is the last in the list. The entire `HStack` is made tappable
    /// by applying the `.contentShape(Rectangle())` modifier, ensuring that the tap gesture is
    /// recognized across the entire row. When tapped, the priority item is selected and the
    /// picker view is dismissed with an animation.
    ///
    /// - Parameters:
    ///   - priority: The `PriorityModel` instance containing the details of the priority item.
    ///   - isLast: A boolean indicating if this is the last priority item in the list.
    ///
    /// - Returns: A view containing the priority icon and information, with an optional separator.
    private func priorityRow(for priority: PriorityModel, isLast: Bool) -> some View {
        HStack {
            priorityIcon(for: priority)
            priorityInfo(for: priority, showSeparator: !isLast)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.3)) {
                selectedPriority = priority
                showPicker.toggle()
            }
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
    private func priorityIcon(for priority: PriorityModel) -> some View {
        Image(systemName: "flag.fill")
            .padding(.horizontal, AppSpacers.medium)
            .foregroundStyle(priority.priorityColor ?? .clear)
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
    private func priorityInfo(for priority: PriorityModel, showSeparator: Bool) -> some View {
        VStack(alignment: .leading, spacing: AppSpacers.xsmall) {
            Text(priority.name ?? "")
                .font(FontHelper.applyFont(forTextStyle: .subheadline))
                .padding(AppSpacers.small)
                .frame(maxWidth: .infinity, alignment: .leading)
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
    private var separator: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(maxWidth: .infinity)
            .frame(height: AppSpacers.unity)
    }
}

#Preview {
    PriorityListView(selectedPriority: .constant(.priority1), showPicker: .constant(true))
}
