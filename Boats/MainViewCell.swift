//
//  MainViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class MainViewCell: UITableViewCell {
    let nameLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    
    var nameText: String? {
        didSet {
            nameLabel.text = nameText ?? ""
        }
    }
    
    var descriptionText: String? {
        didSet {
            descriptionLabel.text = descriptionText ?? ""
        }
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: super.intrinsicContentSize().width, height: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = layoutRect
        contentView.frame.size.height = intrinsicContentSize().height
        
        nameLabel.frame.size.width = contentView.bounds.size.width
        nameLabel.textColor = .foreground(status: .future)
        
        descriptionLabel.frame.size.width = contentView.bounds.size.width
        descriptionLabel.textColor = nameLabel.textColor
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .none
        selectionStyle = .none
        
        nameLabel.font = .medium
        nameLabel.text = " "
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = .regular
        descriptionLabel.text = " "
        descriptionLabel.sizeToFit()
        descriptionLabel.frame.origin.y = nameLabel.frame.size.height + 3.0
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
