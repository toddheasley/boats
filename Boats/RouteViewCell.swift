//
//  RouteViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewCell: UITableViewCell {
    @IBOutlet var routeLabel: UILabel!
    @IBOutlet var originLabel: UILabel!
    @IBOutlet var departureView: DepartureView!
    @IBOutlet var providerLabel: UILabel!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        backgroundColor = highlighted ? .highlight() : .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = selected ? .highlight() : .clear
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        backgroundColor = .clear
        selectionStyle = .none
    }
}
