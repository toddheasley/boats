//
//  DepartureView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DepartureView: UIView, StatusView {
    private let departureView: UIView = UIView()
    private let statusLabel: UILabel = UILabel()
    private let timeView: TimeView = TimeView()
    private let carsView: CarsView = CarsView()
    
    var departure: Departure? {
        didSet {
            timeView.time = departure?.time
            carsView.cars = departure?.cars ?? false
            layoutSubviews()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 252.0, height: timeView.intrinsicContentSize.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        departureView.isHidden = bounds.size.width < departureView.intrinsicContentSize.width || bounds.size.height < departureView.intrinsicContentSize.height
        statusLabel.textColor = .foreground(status: status)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        departureView.frame.size.width = bounds.size.width
        departureView.frame.size.height = intrinsicContentSize.height
        departureView.frame.origin.y = (bounds.size.height - departureView.frame.size.height) / 2.0
        departureView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        addSubview(departureView)
        
        timeView.frame.size = timeView.intrinsicContentSize
        timeView.frame.origin.x =  departureView.frame.size.width - timeView.frame.size.width
        timeView.autoresizingMask = [.flexibleLeftMargin]
        departureView.addSubview(timeView)
        
        carsView.frame.size = carsView.intrinsicContentSize
        carsView.frame.origin.y =  departureView.frame.size.height - carsView.frame.size.height - 4.0
        carsView.autoresizingMask = [.flexibleTopMargin]
        departureView.addSubview(carsView)
        
        statusLabel.font = .small
        statusLabel.text = " "
        statusLabel.sizeToFit()
        statusLabel.frame.size.width = 35.0
        statusLabel.frame.origin.x = 1.0
        statusLabel.frame.origin.y = 3.0
        departureView.addSubview(statusLabel)
        
        layoutSubviews()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: StatusView
    var status: Status = .past {
        didSet {
            timeView.status = status
            carsView.status = status
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
}

enum DepartureCellStyle {
    case collection, table
}

class DepartureCell: UICollectionViewCell, StatusView {
    private let departureView: DepartureView = DepartureView()
    
    var style: DepartureCellStyle = .collection {
        didSet {
            layoutSubviews()
        }
    }
    
    var departure: Departure? {
        set {
            departureView.departure = newValue
        }
        get {
            return departureView.departure
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return departureView.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch style {
        case .collection:
            contentView.layer.cornerRadius = 6.0
            
            departureView.frame.size.width = contentView.frame.size.width - 8.0
            departureView.frame.size.height = contentView.frame.size.height - 8.0
            departureView.frame.origin.x = 4.0
            departureView.frame.origin.y = 4.0
        case .table:
            contentView.layer.cornerRadius = 0.0
            
            departureView.frame.size.width = layoutRect.size.width
            departureView.frame.size.height = contentView.bounds.size.height
            departureView.frame.origin.x = layoutRect.origin.x
            departureView.frame.origin.y = 0.0
        }
        
        //contentView.backgroundColor = UIColor.red.withAlphaComponent(0.1)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.addSubview(departureView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: StatusView
    var status: Status {
        set {
            departureView.status = newValue
        }
        get {
            return departureView.status
        }
    }
}
