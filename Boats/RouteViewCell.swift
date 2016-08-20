//
//  RouteViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewCell: UITableViewCell, ModeView {
    let routeLabel: RouteLabel = RouteLabel()
    let originLabel: UILabel = UILabel()
    let departureView: DepartureView = DepartureView()
    let providerLabel: ProviderLabel = ProviderLabel()
    
    var provider: Provider? {
        set {
            providerLabel.provider = newValue
        }
        get {
            return providerLabel.provider
        }
    }
    
    var route: Route? {
        didSet {
            routeLabel.route = route
            if let route = route {
                originLabel.text = "From \(route.origin.name)"
            } else {
                originLabel.text = ""
            }
            departureView.departure = route?.schedule()?.departure()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentView.frame.size
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        backgroundColor = highlighted ? UIColor.foreground(mode: mode).highlight : .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? UIColor.foreground(mode: mode).highlight : .clear
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
        
        originLabel.frame.size.width = routeLabel.frame.size.width
        originLabel.frame.origin.y = routeLabel.frame.origin.y + routeLabel.frame.size.height + 1.0
        
        providerLabel.frame.size.width = routeLabel.frame.size.width
        contentView.frame.origin.y = (frame.size.height - contentView.frame.size.height) / 2.0
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        routeLabel.mode = mode
        contentView.addSubview(routeLabel)
        
        originLabel.font = .medium
        originLabel.textColor = .foreground(mode: mode)
        originLabel.text = " "
        originLabel.sizeToFit()
        contentView.addSubview(originLabel)
        
        departureView.mode = mode
        departureView.status = .next
        contentView.addSubview(departureView)
        
        providerLabel.mode = mode
        contentView.addSubview(providerLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            routeLabel.mode = mode
            originLabel.textColor = .foreground(mode: mode)
            departureView.mode = mode
            providerLabel.mode = mode
        }
    }
}
