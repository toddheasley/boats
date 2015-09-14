//
//  MainTableHeaderView.swift
//  Boats
//
//  (c) 2015 @toddheasley
//

import UIKit

class MainTableHeaderView: UIView {
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = UILabel(frame: CGRectMake(10.0, bounds.size.height - 66.0, bounds.size.width - 20.0, 35.0))
        nameLabel.font = UIFont.systemFontOfSize(23.0)
        nameLabel.textColor = UIColor.darkGrayColor()
        nameLabel.textAlignment = .Center
        nameLabel.text = "Ferry Schedules"
        addSubview(nameLabel)
        
        descriptionLabel = UILabel(frame: CGRectMake(10.0, nameLabel.frame.origin.y + nameLabel.frame.size.height, bounds.size.width - 20.0, 21.0))
        descriptionLabel.font = UIFont.systemFontOfSize(13.0)
        descriptionLabel.textColor = nameLabel.textColor
        descriptionLabel.textAlignment = .Center
        descriptionLabel.text = "Casco Bay Islands"
        addSubview(descriptionLabel)
    }

    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
