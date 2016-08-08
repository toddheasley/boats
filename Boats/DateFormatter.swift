//
//  DateFormatter.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import Foundation
import BoatsData

extension Foundation.DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    func string(start: Date, end: Date? = nil) -> String {
        guard let end = end else {
            return string(from: start.date)
        }
        return "\(string(from: start.date))-\(string(from: end.date))"
    }
}
