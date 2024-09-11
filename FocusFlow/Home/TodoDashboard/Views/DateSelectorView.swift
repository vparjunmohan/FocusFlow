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
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    init() {
        dateFormatter.dateFormat = "dd MMM"
        updateDaysInMonth(for: Date())
    }
    
    var body: some View {
        VStack {
            // Dropdown for month selection
            HStack {
                Text("Your Timeline")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Picker("Month", selection: $selectedMonth) {
                    ForEach(1...12, id: \.self) { month in
                        Text(dateFormatter.monthSymbols[month - 1]).tag(month)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedMonth, perform: { value in
                    if let newMonthDate = calendar.date(from: DateComponents(year: calendar.component(.year, from: Date()), month: selectedMonth)) {
                        updateDaysInMonth(for: newMonthDate)
                    }
                })
            }
            .padding()

            // Horizontal scrollable date picker
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(daysInMonth, id: \.self) { date in
                        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                        VStack {
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
                }
                .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            updateDaysInMonth(for: Date())
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
        daysInMonth = range.compactMap { day -> Date? in
            return calendar.date(bySetting: .day, value: day, of: date)
        }
    }
}

#Preview {
    DateSelectorView()
}
