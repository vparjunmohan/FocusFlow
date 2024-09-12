//
//  DateSelectorView.swift
//  FocusFlow
//
//  Created by Arjun Mohan on 11/09/24.
//

import SwiftUI

struct DateSelectorView: View {
    @State private var selectedDate = Date()
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    @State private var daysInMonth: [Date] = []
    
    private let calendar = Calendar.current
    private let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateFormat = "dd MMM"
        updateDaysInMonth(for: Date())
    }
    
    var body: some View {
        VStack {
            monthSelectionView
            dateScrollView
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            updateDaysInMonth(for: Date())
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
        Picker("Month", selection: $selectedMonth) {
            ForEach(1...12, id: \.self) { month in
                Text(dateFormatter.monthSymbols[month - 1]).tag(month)
            }
        }
        .pickerStyle(MenuPickerStyle())
        .onChange(of: selectedMonth) { newMonth in
            updateMonthIfNeeded(newMonth)
        }
    }
    
    private var dateScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(daysInMonth, id: \.self) { date in
                    dateSelectionView(for: date)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private func dateSelectionView(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        return VStack {
            Text(getDayString(from: date))
                .font(.subheadline)
                .foregroundColor(.white)
            Text(getDateString(from: date))
                .font(.headline)
                .foregroundColor(isSelected ? .black : .white)
                .padding(10)
                .background(isSelected ? Color.orange : Color.clear)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .onTapGesture {
            selectedDate = date
        }
    }
    
    private func getDayString(from date: Date) -> String {
        let weekday = calendar.component(.weekday, from: date)
        return dateFormatter.shortWeekdaySymbols[weekday - 1]
    }

    private func getDateString(from date: Date) -> String {
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: date)
    }
    
    private func updateDaysInMonth(for date: Date) {
        let range = calendar.range(of: .day, in: .month, for: date)!
        daysInMonth = range.compactMap { day in
            calendar.date(bySetting: .day, value: day, of: date)
        }
    }
    
    private func updateMonthIfNeeded(_ newMonth: Int) {
        if let newMonthDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: Date()), month: newMonth)) {
            updateDaysInMonth(for: newMonthDate)
        }
    }
}

#Preview {
    DateSelectorView()
}
