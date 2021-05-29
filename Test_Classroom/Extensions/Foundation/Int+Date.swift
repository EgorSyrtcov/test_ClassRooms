//
//  Int+Date.swift
//  Test_Classroom
//
//  Created by Egor Syrtcov on 5/29/21.
//

import Foundation

extension Int {
    
    var formattedDate: String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        let string = "\(date)"
        guard let receivedDate = string.split(separator: " ").first?.replacingOccurrences(of: "-", with: ".") else { return "unknown date format" }
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        guard let receivedFormattedDate = dateFormatter.date(from: receivedDate) else {
            return "unknown date format"
        }
        let receivedDay = calendar.component(.day, from: receivedFormattedDate)
        let receivedMonth = calendar.component(.month, from: receivedFormattedDate)
        let receivedYear = calendar.component(.year, from: receivedFormattedDate)

        let currentDate = Date()
        let currentDay = calendar.component(.day, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        guard receivedDay == currentDay, receivedMonth == currentMonth, receivedYear == currentYear else {
            return "Last updated: \(receivedDate)"
        }
        
        return "Last updated: Today"
    }
}
