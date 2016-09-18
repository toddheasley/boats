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
    
    var color: UIColor {
        set {
            label.textColor = newValue
        }
        get {
            return label.textColor
        }
    }
    
    private func setUp() {
        label.font = .systemFont(ofSize: 14.0, weight: UIFontWeightBold)
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.frame.size.height = bounds.size.height
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - 32.0
        label.frame.origin.x = 16.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
}
