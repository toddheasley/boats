//
//  DirectionControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DirectionControl: UISegmentedControl {
    var direction: Direction {
        set {
            selectedSegmentIndex = (newValue == .origin) ? 1 : 0
        }
        get {
            return (selectedSegmentIndex == 0) ? .destination : .origin
        }
    }
    
    var origin: Location? {
        didSet {
            if let origin = origin {
                setTitle("From \(origin.name)".uppercased(), forSegmentAt: 0)
                setTitle("To \(origin.name)".uppercased(), forSegmentAt: 1)
            } else {
                setTitle("", forSegmentAt: 0)
                setTitle("", forSegmentAt: 1)
            }
            layoutSubviews()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 21.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tintColor = UIColor.foreground.withAlphaComponent(0.95)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setTitleTextAttributes([
            NSFontAttributeName: UIFont.small
            ], for: .normal)
        insertSegment(withTitle: "", at: 0, animated: false)
        insertSegment(withTitle: "", at: 1, animated: false)
        selectedSegmentIndex = 0
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
