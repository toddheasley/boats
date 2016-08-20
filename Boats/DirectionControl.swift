//
//  DirectionControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DirectionControl: UISegmentedControl, ModeView {
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
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 25.0)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        tintColor = .control(mode: mode)
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
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            tintColor = .control(mode: mode)
        }
    }
}
