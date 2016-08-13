//
//  RouteViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewCell: UITableViewCell {
    let routeLabel: UILabel =  UILabel()
    let originLabel: UILabel = UILabel()
    let departureView: DepartureView = DepartureView()
    let providerLabel: UILabel = UILabel()
    
    var provider: Provider? {
        didSet {
            if let provider = provider {
                providerLabel.text = "Operated by \(provider.name)"
            } else {
                providerLabel.text = ""
            }
            layoutSubviews()
        }
    }
    
    var route: Route? {
        didSet {
            departureView.departure = route?.schedule()?.departure()
            routeLabel.text = (route?.name ?? "")
            if let route = route {
                originLabel.text = "From \(route.origin.name)"
            } else {
                originLabel.text = ""
            }
            layoutSubviews()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentView.frame.size
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
        
        contentView.frame = layoutRect
        if contentView.bounds.size.width > departureView.intrinsicContentSize.width * 2.0 {
            departureView.frame.size = departureView.intrinsicContentSize
            departureView.frame.origin.x = contentView.bounds.size.width - departureView.frame.size.width
            departureView.frame.origin.y = 0.0
            
            routeLabel.frame.size.width = departureView.frame.origin.x - layoutEdgeInsets.right
            
            providerLabel.frame.origin.y = (departureView.frame.origin.y + departureView.frame.size.height) - providerLabel.frame.size.height
            
            contentView.frame.size.height = departureView.frame.size.height
        } else {
            routeLabel.frame.size.width = contentView.frame.size.width
            
            departureView.frame.size.width = contentView.bounds.size.width
            departureView.frame.size.height = departureView.intrinsicContentSize.height + 5.0
            
            departureView.frame.origin.x = 0.0
            departureView.frame.origin.y = originLabel.frame.origin.y + originLabel.frame.size.height
            
            providerLabel.frame.origin.y = departureView.frame.origin.y + departureView.frame.size.height + 1.0
            
            contentView.frame.size.height = providerLabel.frame.origin.y + providerLabel.frame.size.height
        }
        routeLabel.frame.origin.y = 2.0
        routeLabel.textColor = .foreground
        
        originLabel.frame.size.width = routeLabel.frame.size.width
        originLabel.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height + 1.0
        originLabel.textColor = routeLabel.textColor
        
        providerLabel.frame.size.width = routeLabel.frame.size.width
        providerLabel.textColor = routeLabel.textColor
        
        contentView.frame.origin.y = (frame.size.height - contentView.frame.size.height) / 2.0
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .none
        selectionStyle = .none
        
        routeLabel.font = .large
        routeLabel.text = " "
        routeLabel.sizeToFit()
        contentView.addSubview(routeLabel)
        
        originLabel.font = .medium
        originLabel.text = " "
        originLabel.sizeToFit()
        contentView.addSubview(originLabel)
        
        departureView.status = .next
        contentView.addSubview(departureView)
        
        providerLabel.font = .regular
        providerLabel.text = " "
        providerLabel.sizeToFit()
        contentView.addSubview(providerLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
