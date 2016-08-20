//
//  MainViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class MainViewCell: UITableViewCell, ModeView {
    let nameLabel: UILabel = UILabel()
    let descriptionLabel: UILabel = UILabel()
    
    var data: Data? {
        didSet {
            nameLabel.text = data?.name ?? ""
            descriptionLabel.text = data?.description ?? ""
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: descriptionLabel.frame.origin.y + descriptionLabel.frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = layoutRect
        contentView.frame.size.height = intrinsicContentSize.height
        nameLabel.frame.size.width = contentView.bounds.size.width
        descriptionLabel.frame.size.width = contentView.bounds.size.width
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .background(mode: mode)
        selectionStyle = .none
        
        nameLabel.font = .medium
        nameLabel.textColor = .foreground(mode: mode)
        nameLabel.text = " "
        nameLabel.sizeToFit()
        contentView.addSubview(nameLabel)
        
        descriptionLabel.font = .regular
        descriptionLabel.textColor = nameLabel.textColor
        descriptionLabel.text = " "
        descriptionLabel.sizeToFit()
        descriptionLabel.frame.origin.y = nameLabel.frame.size.height + 3.0
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            backgroundColor = .background(mode: mode)
            nameLabel.textColor = .foreground(mode: mode)
            descriptionLabel.textColor = nameLabel.textColor
        }
    }
}
