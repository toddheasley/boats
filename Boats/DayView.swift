//
//  DayView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DayView: UICollectionReusableView {
    private let label: UILabel = UILabel()
    
    var day: Day? {
        didSet {
            label.text = day?.rawValue ?? ""
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: label.frame.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = layoutRect.size.width
        label.frame.origin.x = layoutRect.origin.x
        label.frame.origin.y = bounds.size.height - label.frame.size.height
        label.textColor = .foreground
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        label.font = .medium
        label.text = " "
        label.sizeToFit()
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
