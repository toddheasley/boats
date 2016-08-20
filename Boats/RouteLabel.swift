//
//  RouteLabel.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class RouteLabel: UILabel, ModeView {
    var route: Route? {
        didSet {
            text = route?.name ?? ""
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: frame.size.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .large
        textColor = .foreground(mode: mode)
        text = " "
        sizeToFit()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            textColor = .foreground(mode: mode)
        }
    }
}
