//
//  DepartureViewCell.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class DepartureViewCell: UICollectionViewCell {
    private let view: DepartureView = DepartureView()
    
    var departure: Departure? {
        set {
            view.departure = newValue
        }
        get {
            return view.departure
        }
    }
    
    var status: DepartureStatus {
        set {
            view.status = newValue
        }
        get {
            return view.status
        }
    }
    
    var color: UIColor {
        set {
            view.color = newValue
        }
        get {
            return view.color
        }
    }
    
    private func setUp() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.frame = bounds
        contentView.addSubview(view)
    }
    
    override var intrinsicContentSize: CGSize {
        return view.intrinsicContentSize
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
