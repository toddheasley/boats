//
//  DepartureView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

enum DepartureStatus {
    case past, next, soon, last
    
    var alpha: CGFloat {
        switch self {
        case .past:
            return 0.3
        case .next:
            return 1.0
        default:
            return 0.6
        }
    }
}

class DepartureView: UIView {
    private let view: UIView = UIView()
    private let statusLabel: UILabel = UILabel()
    private let carsView: UIImageView = UIImageView()
    private let timeView: TimeView = TimeView()
    
    var departure: Departure? {
        didSet {
            timeView.time = departure?.time
            layoutSubviews()
        }
    }
    
    var status: DepartureStatus = .soon {
        didSet {
            switch status {
            case .next:
                statusLabel.text = "Next".uppercased()
            case .last:
                statusLabel.text = "Last".uppercased()
            default:
                statusLabel.text = ""
            }
            layoutSubviews()
        }
    }
    
    var color: UIColor {
        set {
            statusLabel.textColor = newValue
            carsView.image = UIImage(named: "Cars")?.tint(color: newValue)
            timeView.color = newValue
        }
        get {
            return statusLabel.textColor
        }
    }
    
    private func setUp() {
        timeView.frame.size = timeView.intrinsicContentSize
        timeView.frame.origin.x = view.bounds.size.width - timeView.frame.size.width
        timeView.autoresizingMask = [.flexibleLeftMargin]
        view.addSubview(timeView)
        
        statusLabel.font = .systemFont(ofSize: 9.0, weight: UIFontWeightHeavy)
        statusLabel.text = ""
        statusLabel.frame.size = CGSize(width: 35.0, height: 11.0)
        statusLabel.frame.origin.y = 4.0
        view.addSubview(statusLabel)
        
        carsView.contentMode = .scaleAspectFit
        carsView.frame.size = CGSize(width: 27.0, height: 27.0)
        carsView.frame.origin.y = view.bounds.size.height - carsView.frame.size.height
        carsView.autoresizingMask = [.flexibleTopMargin]
        view.addSubview(carsView)
        
        view.frame.size = intrinsicContentSize
        view.frame.origin.y = bounds.size.height - view.frame.size.height
        view.autoresizingMask = [.flexibleTopMargin]
        addSubview(view)
        
        color = statusLabel.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.size.width > 480.0 {
            view.frame.size.width = intrinsicContentSize.width
            view.frame.origin.x = bounds.size.width - view.frame.size.width
        } else {
            view.frame.size.width = bounds.size.width
            view.frame.origin.x = 0.0
        }
        
        if let departure = departure {
            statusLabel.alpha = status.alpha
            carsView.alpha = departure.cars ? status.alpha : 0.05
            timeView.alpha = status.alpha
        } else {
            statusLabel.alpha = 0.05
            carsView.alpha = statusLabel.alpha
            timeView.alpha = statusLabel.alpha
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 252.0, height: timeView.intrinsicContentSize.height)
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
