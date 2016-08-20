//
//  SeasonLabel.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class SeasonLabel: UILabel, ModeView {
    private static let dateFormatter: DateFormatter = DateFormatter()
    
    var schedule: Schedule? {
        didSet {
            guard let schedule = schedule else {
                text = "Schedule Unavailable"
                return
            }
            SeasonLabel.dateFormatter.dateFormat = "MMM d, yyyy"
            switch schedule.season {
            case .all:
                text = "Year-Round"
            default:
                text = "\(schedule.season.rawValue): \(SeasonLabel.dateFormatter.string(from: schedule.dates.start.date)) - \(SeasonLabel.dateFormatter.string(from: schedule.dates.end.date))"
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: frame.size.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .medium
        textColor = .foreground(mode: mode)
        text = " "
        sizeToFit()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            textColor = .foreground(mode: mode)
        }
    }
}
