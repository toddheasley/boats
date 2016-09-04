//
//  RouteViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteViewCell: UITableViewCell {
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var departureView: DepartureView!
    @IBOutlet weak var providerLabel: UILabel!
    
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
