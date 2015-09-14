//
//  DepartureTableViewCell.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class DepartureTableViewCell: UITableViewCell {
    static var height: CGFloat = 68.0
    private var hourLabels: [UILabel] = []
    private var separatorLabel: UILabel!
    private var minuteLabels: [UILabel] = []
    private var periodLabel: UILabel!
    private var carLabel: UILabel!
    
    var departure: Departure? {
        didSet {
            layoutSubviews()
        }
    }
    
    var status: DepartureStatus = .Past {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let departure = departure {
            let hour = String(format: "%02d", (departure.time.hour < 1 || departure.time.hour > 12) ? abs(departure.time.hour - 12) : departure.time.hour)
            let minute = String(format: "%02d", departure.time.minute)
            
            hourLabels[0].text = "\(hour.characters.first!)"
            hourLabels[1].text = "\(hour.characters.last!)"
            minuteLabels[0].text = "\(minute.characters.first!)"
            minuteLabels[1].text = "\(minute.characters.last!)"
            periodLabel.text = (departure.time.hour > 11) ? "PM" : "AM"
            
            carLabel.hidden = !departure.cars
        } else {
            hourLabels[0].text = "0"
            hourLabels[1].text = "0"
            minuteLabels[0].text = "0"
            minuteLabels[1].text = "0"
            periodLabel.text = "AM"
            
            carLabel.hidden = true
        }
        
        for view in contentView.subviews {
            if let view = view as? UILabel {
                view.textColor = (status == .Current) ? UIColor.whiteColor() : UIColor.darkGrayColor()
            }
        }
        contentView.backgroundColor = (status == .Current) ? tintColor : UIColor.clearColor()
        contentView.alpha = (status == .Past) ? 0.1 : 1.0
        hourLabels[0].alpha = (status == .Past || hourLabels[0].text != "0") ? 1.0 : 0.1
        
        separatorInset = UIEdgeInsetsZero
        layoutMargins = (status == .Current) ? UIEdgeInsetsZero : UIEdgeInsetsMake(0.0, hourLabels[0].frame.origin.x, 0.0, 0.0)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        preservesSuperviewLayoutMargins = false
        
        hourLabels.append(UILabel())
        hourLabels[0].frame = CGRectMake(15.0, 0.0, 28.0, contentView.bounds.size.height)
        hourLabels[0].autoresizingMask = [.FlexibleHeight]
        hourLabels[0].font = UIFont.systemFontOfSize(43.0)
        hourLabels[0].textAlignment = .Center
        contentView.addSubview(hourLabels[0])
        
        hourLabels.append(UILabel())
        hourLabels[1].frame = CGRectMake(hourLabels[0].frame.origin.x + hourLabels[0].frame.size.width, 0.0, hourLabels[0].frame.size.width, contentView.bounds.size.height)
        hourLabels[1].autoresizingMask = hourLabels[0].autoresizingMask
        hourLabels[1].font = UIFont.systemFontOfSize(43.0)
        hourLabels[1].textAlignment = .Center
        contentView.addSubview(hourLabels[1])
        
        separatorLabel = UILabel(frame: CGRectMake(hourLabels[1].frame.origin.x + hourLabels[1].frame.size.width, 0.0, 13.0, contentView.bounds.size.height - 9.0))
        separatorLabel.autoresizingMask = [.FlexibleHeight]
        separatorLabel.font = UIFont.systemFontOfSize(43.0)
        separatorLabel.textAlignment = .Center
        separatorLabel.text = ":"
        contentView.addSubview(separatorLabel)
        
        minuteLabels.append(UILabel())
        minuteLabels[0].frame = CGRectMake(separatorLabel.frame.origin.x + separatorLabel.frame.size.width, 0.0, hourLabels[0].frame.size.width, contentView.bounds.size.height)
        minuteLabels[0].autoresizingMask = [.FlexibleHeight]
        minuteLabels[0].font = UIFont.systemFontOfSize(43.0)
        minuteLabels[0].textAlignment = .Center
        contentView.addSubview(minuteLabels[0])
        
        minuteLabels.append(UILabel())
        minuteLabels[1].frame = CGRectMake(minuteLabels[0].frame.origin.x + minuteLabels[0].frame.size.width, 0.0, minuteLabels[0].frame.size.width, contentView.bounds.size.height)
        minuteLabels[1].autoresizingMask = [.FlexibleHeight]
        minuteLabels[1].font = UIFont.systemFontOfSize(43.0)
        minuteLabels[1].textAlignment = .Center
        contentView.addSubview(minuteLabels[1])
        
        periodLabel = UILabel(frame: CGRectMake(minuteLabels[1].frame.origin.x + minuteLabels[1].frame.size.width, 0.0, 27.0, contentView.bounds.size.height - 22.0))
        periodLabel.autoresizingMask = [.FlexibleHeight]
        periodLabel.font = UIFont.systemFontOfSize(12.0)
        periodLabel.textAlignment = .Center
        contentView.addSubview(periodLabel)
        
        carLabel = UILabel(frame: CGRectMake(contentView.bounds.size.width - 123.0, 0.0, 100.0, contentView.bounds.size.height))
        carLabel.autoresizingMask = [.FlexibleLeftMargin, .FlexibleHeight]
        carLabel.font = textLabel?.font
        carLabel.textAlignment = .Right
        carLabel.text = "Car Ferry"
        contentView.addSubview(carLabel)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
