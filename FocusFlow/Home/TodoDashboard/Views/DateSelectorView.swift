//
//  DateSelectorView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 11/09/24.
//

import SwiftUI

// MARK: - ViewModel
class DateSelectorViewModel: ObservableObject {
    @Published var selectedDate: Date
    @Published var selectedMonth: Int
    @Published var daysInMonth: [Date] = []
    
    private let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    init() {
        let currentDate = Date()
        self.selectedDate = currentDate
        self.selectedMonth = calendar.component(.month, from: currentDate)
        self.dateFormatter.dateFormat = "dd MMM"
        self.updateDaysInMonth(for: currentDate)
    }
    
    func updateDaysInMonth(for date: Date) {
        let range = calendar.range(of: .day, in: .month, for: date)!
        daysInMonth = range.compactMap { day in
            calendar.date(bySetting: .day, value: day, of: date)
        }
    }
    
    func updateMonthIfNeeded(_ newMonth: Int) {
        if let newMonthDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: Date()), month: newMonth)) {
            updateDaysInMonth(for: newMonthDate)
            if calendar.component(.month, from: Date()) == newMonth {
                // If the selected month is the current month, set selectedDate to today
                selectedDate = Date()
            } else if calendar.component(.month, from: selectedDate) != newMonth {
                // If it's not the current month, set selectedDate to the first day of the month
                selectedDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: newMonthDate), month: newMonth, day: 1)) ?? newMonthDate
            }
        }
    }
    
    func isDateSelected(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: selectedDate)
    }
    
    func getDayString(from date: Date) -> String {
        let weekday = calendar.component(.weekday, from: date)
        return dateFormatter.shortWeekdaySymbols[weekday - 1]
    }
    
    func getDateString(from date: Date) -> String {
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    func scrollToSelectedDate(proxy: ScrollViewProxy) {
        if let dateToScroll = daysInMonth.first(where: { calendar.isDate($0, inSameDayAs: selectedDate) }) {
            withAnimation {
                proxy.scrollTo(dateToScroll, anchor: .center)
            }
        }
    }
}

// MARK: - View
struct DateSelectorView: View {
    @StateObject private var viewModel = DateSelectorViewModel()
    
    var body: some View {
        VStack {
            monthSelectionView
            dateScrollView
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.updateDaysInMonth(for: Date())
            viewModel.selectedDate = Date()
        }
    }
    
    private var monthSelectionView: some View {
        HStack {
            Text("Your Timeline")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            monthPicker
        }
        .padding()
    }
    
    private var monthPicker: some View {
        Picker("Month", selection: $viewModel.selectedMonth) {
            ForEach(1...12, id: \.self) { month in
                Text(viewModel.dateFormatter.monthSymbols[month - 1]).tag(month)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: viewModel.selectedMonth) { newMonth in
            viewModel.updateMonthIfNeeded(newMonth)
        }
    }
    
    private var dateScrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.daysInMonth, id: \.self) { date in
                        dateSelectionView(for: date)
                            .id(date)
                    }
                }
                .padding(.horizontal)
            }
            .onChange(of: viewModel.selectedDate) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    viewModel.scrollToSelectedDate(proxy: proxy)
                }
            }
        }
    }
    
    private func dateSelectionView(for date: Date) -> some View {
        let isSelected = viewModel.isDateSelected(date)
        return VStack {
            Text(viewModel.getDayString(from: date))
                .font(.subheadline)
                .foregroundColor(.white)
            Text(viewModel.getDateString(from: date))
                .font(.headline)
                .foregroundColor(isSelected ? .black : .white)
                .padding(10)
                .background(isSelected ? Color.orange : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onTapGesture {
            viewModel.selectedDate = date
        }
    }
}


#Preview {
    DateSelectorView()
}
