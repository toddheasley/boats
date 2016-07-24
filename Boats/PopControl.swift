//
//  PopControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class PopControl: UIControl {
    private let label: UILabel = UILabel()
    private let imageView: UIImageView = UIImageView()
    
    var text: String? {
        didSet {
            label.text = text?.uppercased() ?? " "
            label.sizeToFit()
            layoutSubviews()
        }
    }
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            layoutSubviews()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            label.alpha = isHighlighted ? UIColor.alpha(status: .past) : UIColor.alpha()
            imageView.alpha = label.alpha
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame.origin.x = contentInset.left
        imageView.frame.origin.y = contentInset.top
        
        label.frame.origin.x = imageView.frame.origin.x + imageView.frame.size.width + 2.5
        label.frame.origin.y = imageView.frame.origin.y
        
        frame.size.width = label.frame.origin.x + label.frame.size.width + contentInset.left + contentInset.right
        frame.size.height = label.frame.size.height + contentInset.top + contentInset.bottom
        
        label.textColor = .foreground(status: .past)
        imageView.image = UIImage(named: "Pop")?.color(label.textColor)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: frame.size.width - (contentInset.left + contentInset.right), height: frame.size.height - (contentInset.top + contentInset.bottom))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .small
        label.text = " "
        label.sizeToFit()
        addSubview(label)
        
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size.height = label.frame.size.height
        imageView.frame.size.width = imageView.frame.size.height * 0.55
        addSubview(imageView)
        
        layoutSubviews()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
