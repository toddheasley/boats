//
//  ScheduleLabel.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ScheduleLabel: UILabel {
    var schedule: Schedule? {
        didSet {
            if let schedule = schedule , schedule.season != .all {
                text = "\(schedule.season.rawValue) \(year(dates: schedule.dates))"
            } else {
                text = ""
            }
        }
    }
    
    private func year(dates: (start: Date, end: Date)) -> String {
        if (dates.start.year == dates.end.year) {
            return "\(dates.start.year)"
        } else if ((dates.start.year / 100) == (dates.end.year / 100)) {
            return "\(dates.start.year)-\(dates.end.year % 100)"
        }
        return "\(dates.start.year)-\(dates.end.year)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textColor = .foreground(season: schedule?.season ?? .all)
    }
}
