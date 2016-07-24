//
//  RouteViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewCell: UITableViewCell {
    private let departureView: DepartureView = DepartureView()
    private let providerLabel: UILabel = UILabel()
    private let routeLabel: UILabel = UILabel()
    private let originLabel: UILabel = UILabel()
    
    private var departure: Departure? {
        guard let schedule = route?.schedule() else {
            return nil
        }
        let date = Date()
        var day = Day()
        for holiday in schedule.holidays {
            if (holiday.date == date) {
                day = .holiday
                break
            }
        }
        let time = Time()
        for departure in schedule.departures(day: day, direction: .destination) {
            if (time < departure.time) {
                return departure
            }
        }
        return nil
    }
    
    var provider: Provider? {
        didSet {
            providerLabel.text = provider?.name.uppercased() ?? ""
        }
    }
    
    var route: Route? {
        didSet {
            departureView.departure = departure
            routeLabel.text = (route?.name ?? "")
            if let route = route {
                originLabel.text = "From \(route.origin.name)"
            } else {
                originLabel.text = ""
            }
            layoutSubviews()
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        backgroundColor = highlighted ? .highlight : .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? .highlight : .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = suggestedFrame
        if (suggestedSizeClass.vertical == .regular) {
            routeLabel.sizeToFit()
            
            departureView.frame.size.width = contentView.bounds.size.width
            departureView.frame.origin.x = 0.0
            departureView.frame.origin.y = providerLabel.frame.size.height + routeLabel.frame.size.height
            
            originLabel.frame.origin.x = routeLabel.frame.size.width + 5.0
            originLabel.frame.origin.y = routeLabel.frame.origin.y
            originLabel.frame.size.width = contentView.frame.size.width - originLabel.frame.origin.x
            originLabel.frame.size.height = routeLabel.frame.size.height
        } else {
            departureView.frame.size.width = departureView.intrinsicContentSize().width
            departureView.frame.origin.x = contentView.bounds.size.width - departureView.frame.size.width
            departureView.frame.origin.y = providerLabel.frame.size.height
            
            routeLabel.frame.size.width = departureView.frame.origin.x
            routeLabel.frame.size.height = departureView.frame.size.height / 2.0
            
            originLabel.frame.size.width = routeLabel.frame.size.width
            originLabel.frame.size.height = routeLabel.frame.size.height
            originLabel.frame.origin.x = 0.0
            originLabel.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height
        }
        contentView.frame.size.height = departureView.frame.origin.y + departureView.frame.size.height
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        providerLabel.textColor = .foreground(status: .past)
        routeLabel.textColor = .foreground
        originLabel.textColor = providerLabel.textColor
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .none
        selectionStyle = .none
        
        departureView.statusText = "Next"
        departureView.frame.size.height = departureView.intrinsicContentSize().height
        contentView.addSubview(departureView)
        
        providerLabel.font = .small
        providerLabel.text = " "
        providerLabel.sizeToFit()
        providerLabel.frame.size.width = bounds.size.width
        providerLabel.autoresizingMask = [.flexibleWidth]
        contentView.addSubview(providerLabel)
        
        routeLabel.font = .large
        routeLabel.frame.origin.y = providerLabel.frame.size.height
        contentView.addSubview(routeLabel)
        
        originLabel.font = routeLabel.font
        contentView.addSubview(originLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
