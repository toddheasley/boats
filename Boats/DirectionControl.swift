//
//  DirectionControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DirectionControl: SegmentedControl {
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
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        insertSegment(withTitle: "", at: 0, animated: false)
        insertSegment(withTitle: "", at: 1, animated: false)
        selectedSegmentIndex = 0
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
}
