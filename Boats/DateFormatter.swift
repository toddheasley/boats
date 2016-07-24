//
//  DateFormatter.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation

class DateFormatter: Foundation.DateFormatter {
    static let shared: DateFormatter = DateFormatter(dateFormat: "EE, MMM d")
}

extension Foundation.DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
