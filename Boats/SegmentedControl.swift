//
//  SegmentedControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class SegmentedControl: UISegmentedControl {
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: super.intrinsicContentSize().width, height: 17.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintColor = .foreground
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleTextAttributes([
            NSFontAttributeName: UIFont.xsmall
        ], for: .normal)
        alpha = 0.9
    }
    
    convenience init() {
        self.init(frame: CGRect())
        self.frame.size = intrinsicContentSize()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
