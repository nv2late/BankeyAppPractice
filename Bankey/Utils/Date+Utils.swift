//
//  Date+Utils.swift
//  Bankey
//
//  Created by Reese on 2022/08/17.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MM d, yyyy"
        return dateFormatter.string(from: self)
    }
}
