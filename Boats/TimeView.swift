//
//  TimeView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class TimeView: UIView {
    private static let timeFormatter: DateFormatter = DateFormatter()
    private let view: UIView = UIView()
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
    
    var color: UIColor = UILabel().textColor {
        didSet {
            hourLabels.0.textColor = color
            hourLabels.1.textColor = color
            minuteLabels.0.textColor = color
            minuteLabels.1.textColor = color
            separatorLabel.textColor = color
            periodLabel.textColor = color
        }
    }
    
    override var alpha: CGFloat {
        set {
            separatorLabel.alpha = newValue
            layoutSubviews()
        }
        get {
            return separatorLabel.alpha
        }
    }
    
    private func setUp() {
        let font: UIFont = .systemFont(ofSize: 64.0, weight: UIFontWeightHeavy)
        var frame: CGRect = CGRect(x: 21.0, y: 0.0, width: 42.0, height: 56.0)
        
        view.frame.size.width = (frame.size.width * 5.0) + frame.origin.x
        view.frame.size.height = frame.size.height
        view.frame.origin.x = (bounds.size.width - view.frame.size.width) / 2.0
        view.frame.origin.y = (bounds.size.height - view.frame.size.height) / 2.0
        view.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin, .flexibleBottomMargin, .flexibleLeftMargin]
        view.clipsToBounds = true
        addSubview(view)
        
        hourLabels.0.frame = frame
        hourLabels.0.font = font
        hourLabels.0.textAlignment = .center
        hourLabels.0.text = "0"
        view.addSubview(hourLabels.0)
        frame.origin.x += frame.size.width
        
        hourLabels.1.frame = frame
        hourLabels.1.font = font
        hourLabels.1.textAlignment = .center
        hourLabels.1.text = "0"
        view.addSubview(hourLabels.1)
        frame.origin.x += frame.size.width
        
        separatorLabel.frame = CGRect(x: frame.origin.x, y: frame.origin.y - (frame.size.height * 0.025), width: frame.size.width / 2.0, height: frame.size.height)
        separatorLabel.font = font
        separatorLabel.textAlignment = .center
        separatorLabel.text = ":"
        view.addSubview(separatorLabel)
        frame.origin.x += separatorLabel.frame.size.width
        
        minuteLabels.0.frame = frame
        minuteLabels.0.font = font
        minuteLabels.0.textAlignment = .center
        minuteLabels.0.text = "0"
        view.addSubview(minuteLabels.0)
        frame.origin.x += frame.size.width
        
        minuteLabels.1.frame = frame
        minuteLabels.1.font = font
        minuteLabels.1.textAlignment = .center
        minuteLabels.1.text = "0"
        view.addSubview(minuteLabels.1)
        frame.origin.x += frame.size.width
        
        periodLabel.frame = CGRect(x: frame.origin.x, y: separatorLabel.frame.origin.y, width: frame.size.width / 2.0, height: frame.size.height)
        periodLabel.font = font
        periodLabel.textAlignment = .center
        periodLabel.text = "."
        view.addSubview(periodLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let time = time {
            periodLabel.alpha = (alpha != 0.1 && time.hour < 12) ? 0.05 : alpha
            hourLabels.0.alpha = (hourLabels.0.text != "0") ? alpha : 0.05
            hourLabels.1.alpha = alpha
            minuteLabels.0.alpha = alpha
            minuteLabels.1.alpha = alpha
            separatorLabel.alpha = alpha
        } else {
            periodLabel.alpha = 0.05
            hourLabels.0.alpha = periodLabel.alpha
            hourLabels.1.alpha = periodLabel.alpha
            minuteLabels.0.alpha = periodLabel.alpha
            minuteLabels.1.alpha = periodLabel.alpha
            separatorLabel.alpha = periodLabel.alpha
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return view.frame.size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
}
