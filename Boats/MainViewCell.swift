//
//  MainViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class MainViewCell: UITableViewCell {
    private let nameLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    var data: Data? {
        didSet {
            nameLabel.text = data?.name ?? ""
            descriptionLabel.text = data?.description ?? ""
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = suggestedFrame
        contentView.frame.size.height = nameLabel.frame.size.height + descriptionLabel.frame.size.height
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        nameLabel.textColor = .foreground
        descriptionLabel.textColor = nameLabel.textColor
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .none
        selectionStyle = .none
        
        nameLabel.font = .xlarge
        nameLabel.text = " "
        nameLabel.sizeToFit()
        nameLabel.frame.size.width = contentView.bounds.size.width
        nameLabel.autoresizingMask = [.flexibleWidth]
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = .medium
        descriptionLabel.text = " "
        descriptionLabel.sizeToFit()
        descriptionLabel.frame.size.width = contentView.bounds.size.width
        descriptionLabel.frame.origin.y = nameLabel.frame.size.height
        descriptionLabel.autoresizingMask = [.flexibleWidth]
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
