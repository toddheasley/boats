//
//  ProviderControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class ProviderControl: UIControl {
    private let label: UILabel = UILabel()
    
    var text: String? {
        set {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            label.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return label.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
        label.textColor = .foreground
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .regular
        label.text = " "
        label.sizeToFit()
        addSubview(label)
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
