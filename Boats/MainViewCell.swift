//
//  MainViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class MainViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        selectionStyle = .none
    }
}
