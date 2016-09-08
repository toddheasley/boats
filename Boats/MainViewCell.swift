//
//  MainViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class MainViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        selectionStyle = .none
    }
}
