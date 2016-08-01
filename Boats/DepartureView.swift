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
    
    var statusText: String? {
        didSet {
            statusLabel.text = statusText?.uppercased() ?? ""
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 242.0, height: timeView.intrinsicContentSize().height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        departureView.isHidden = bounds.size.width < departureView.intrinsicContentSize().width || bounds.size.height < departureView.intrinsicContentSize().height
        statusLabel.textColor = .foreground(status: status)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        departureView.frame.size.width = bounds.size.width
        departureView.frame.size.height = intrinsicContentSize().height
        departureView.frame.origin.y = (bounds.size.height - departureView.frame.size.height) / 2.0
        departureView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        addSubview(departureView)
        
        timeView.frame.size = timeView.intrinsicContentSize()
        timeView.frame.origin.x =  departureView.frame.size.width - timeView.frame.size.width
        timeView.autoresizingMask = [.flexibleLeftMargin]
        departureView.addSubview(timeView)
        
        carsView.frame.size = carsView.intrinsicContentSize()
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
    var status: Status = .future {
        didSet {
            timeView.status = status
            carsView.status = status
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
            
            //departureView.frame.size.width = suggestedFrame.size.width - 6.0
            departureView.frame.size.height = contentView.bounds.size.height
            //departureView.frame.origin.x = suggestedFrame.origin.x + 4.0
            departureView.frame.origin.y = 0.0
        }
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
            switch status {
            case .next:
                departureView.statusText = "Next"
            case .last:
                departureView.statusText = "Last"
            default:
                departureView.statusText = nil
            }
        }
        get {
            return departureView.status
        }
    }
}
