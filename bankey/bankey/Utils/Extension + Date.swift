//
//  Extension + Date.swift
//  bankey
//
//  Created by Guilherme Viana on 14/02/2024.
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
		dateFormatter.dateFormat = "MMM d, yyyy"
		return dateFormatter.string(from: self)
	}
}
