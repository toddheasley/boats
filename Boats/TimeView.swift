//
//  TimeView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class TimeView: UIView, StatusView {
    private static let timeFormatter: DateFormatter = DateFormatter()
    private let timeView: UIView = UIView()
    private let hourLabels: (UILabel, UILabel) = (UILabel(), UILabel())
    private let minuteLabels: (UILabel, UILabel) = (UILabel(), UILabel())
    private let separatorLabel: UILabel = UILabel()
    private let periodLabel: UILabel = UILabel()
    
    var time: Time? {
        didSet {
            periodLabel.isHidden = is24HourTime
            var hour: String = "00"
            var minute: String = "00"
            if let time = time {
                hour = String(format: "%02d", (!is24HourTime && (time.hour < 1 || time.hour > 12)) ? abs(time.hour - 12) : time.hour)
                minute = String(format: "%02d", time.minute)
            }
            hourLabels.0.text = "\(hour.characters.first!)"
            hourLabels.1.text = "\(hour.characters.last!)"
            minuteLabels.0.text = "\(minute.characters.first!)"
            minuteLabels.1.text = "\(minute.characters.last!)"
            layoutSubviews()
        }
    }
    
    var is24HourTime: Bool {
        TimeView.timeFormatter.dateStyle = .none
        TimeView.timeFormatter.timeStyle = .short
        return !TimeView.timeFormatter.string(from: Foundation.Date()).contains(" ")
    }
    
    override var intrinsicContentSize: CGSize {
        return timeView.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        timeView.isHidden = bounds.size.width < timeView.frame.size.width || bounds.size.height < timeView.frame.size.height
        
        let color: UIColor = .foreground(status: status)
        hourLabels.0.textColor = (hourLabels.0.text != "0") ? color : color.disabled
        if let time = time {
            hourLabels.1.textColor = color
            minuteLabels.0.textColor = color
            minuteLabels.1.textColor = color
            separatorLabel.textColor = color
            periodLabel.textColor = (time.hour < 12) ? color.disabled : color
        } else {
            hourLabels.1.textColor = hourLabels.0.textColor
            minuteLabels.0.textColor = hourLabels.0.textColor
            minuteLabels.1.textColor = hourLabels.0.textColor
            separatorLabel.textColor = hourLabels.0.textColor
            periodLabel.textColor = hourLabels.0.textColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let font: UIFont = UIFont.large.withSize(64.0)
        var frame: CGRect = CGRect(x: 21.0, y: 0.0, width: 42.0, height: 56.0)
        
        timeView.frame.size.width = (frame.size.width * 5.0) + frame.origin.x
        timeView.frame.size.height = frame.size.height
        timeView.frame.origin.x = (bounds.size.width - timeView.frame.size.width) / 2.0
        timeView.frame.origin.y = (bounds.size.height - timeView.frame.size.height) / 2.0
        timeView.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        timeView.clipsToBounds = true
        addSubview(timeView)
        
        hourLabels.0.frame = frame
        hourLabels.0.font = font
        hourLabels.0.textAlignment = .center
        hourLabels.0.text = "0"
        timeView.addSubview(hourLabels.0)
        frame.origin.x += frame.size.width
        
        hourLabels.1.frame = frame
        hourLabels.1.font = font
        hourLabels.1.textAlignment = .center
        hourLabels.1.text = "0"
        timeView.addSubview(hourLabels.1)
        frame.origin.x += frame.size.width
        
        separatorLabel.frame = CGRect(x: frame.origin.x, y: frame.origin.y - (frame.size.height * 0.025), width: frame.size.width / 2.0, height: frame.size.height)
        separatorLabel.font = font
        separatorLabel.textAlignment = .center
        separatorLabel.text = ":"
        timeView.addSubview(separatorLabel)
        frame.origin.x += separatorLabel.frame.size.width
        
        minuteLabels.0.frame = frame
        minuteLabels.0.font = font
        minuteLabels.0.textAlignment = .center
        minuteLabels.0.text = "0"
        timeView.addSubview(minuteLabels.0)
        frame.origin.x += frame.size.width
        
        minuteLabels.1.frame = frame
        minuteLabels.1.font = font
        minuteLabels.1.textAlignment = .center
        minuteLabels.1.text = "0"
        timeView.addSubview(minuteLabels.1)
        frame.origin.x += frame.size.width
        
        periodLabel.frame = CGRect(x: frame.origin.x, y: separatorLabel.frame.origin.y, width: frame.size.width / 2.0, height: frame.size.height)
        periodLabel.font = font
        periodLabel.textAlignment = .center
        periodLabel.text = "."
        timeView.addSubview(periodLabel)
        
        layoutSubviews()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: StatusView
    var status: Status = .past {
        didSet {
            layoutSubviews()
        }
    }
}
