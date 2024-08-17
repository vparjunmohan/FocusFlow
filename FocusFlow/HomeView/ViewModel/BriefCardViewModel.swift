//
//  DayBriefCardViewModel.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 17/08/24.
//

import Foundation

/// ViewModel for managing and providing the current weekday and day of the month.
///
/// The `DayBriefCardViewModel` class is an `ObservableObject` that maintains and updates
/// the current weekday name and day of the month. It uses `DateFormatter` to format the
/// current date and provides methods to update these values.
///
/// Properties:
/// - `currentWeekday`: A published property that holds the abbreviated name of the current weekday (e.g., "Mon", "Tue").
/// - `currentDay`: A published property that holds the day of the month (e.g., "16", "1").
///
/// Initialization:
/// - The `init` method initializes the `DateFormatter` and sets `currentWeekday` and `currentDay`
///   by calling the static method `getCurrentWeekdayAndDay()` to get the current values.
///
/// Methods:
/// - `getCurrentWeekdayAndDay() -> (weekday: String, day: String)`: A static method that returns
///   the current weekday and day of the month formatted as strings. It uses `DateFormatter`
///   to format the date according to "E" (abbreviated weekday) and "d" (day of the month) formats.
/// - `updateCurrentDate()`: Updates the `currentWeekday` and `currentDay` properties with the
///   latest values by calling `getCurrentWeekdayAndDay()` again.
///
/// Usage:
/// - Create an instance of `DayBriefCardViewModel` to manage and provide date-related data
///   for views that need to display or use the current weekday and day.
/// - Call `updateCurrentDate()` to refresh the properties if the date changes or needs updating.
///
/// Example:
/// ```
/// let viewModel = DayBriefCardViewModel()
/// print("Weekday: \(viewModel.currentWeekday)") // e.g., "Mon"
/// print("Day: \(viewModel.currentDay)")         // e.g., "16"
/// viewModel.updateCurrentDate()
/// ```
class DayBriefCardViewModel: ObservableObject {
    @Published var currentWeekday: String
    @Published var currentDay: String
    
    private let dateFormatter: DateFormatter
    
    init() {
        self.dateFormatter = DateFormatter()
        (self.currentWeekday, self.currentDay) = Self.getCurrentWeekdayAndDay()
    }
    
    private static func getCurrentWeekdayAndDay() -> (weekday: String, day: String) {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "E"
        let weekdayName = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "d"
        let dayOfMonth = dateFormatter.string(from: currentDate)
        
        return (weekday: weekdayName, day: dayOfMonth)
    }
    
    func updateCurrentDate() {
        (self.currentWeekday, self.currentDay) = Self.getCurrentWeekdayAndDay()
    }
}
