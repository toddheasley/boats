//
//  CarsView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class CarsView: UIImageView, ModeView, StatusView {
    var cars: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 27.0, height: 18.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let color: UIColor = .foreground(mode: mode, status: status)
        image = UIImage(named: "Cars")?.tint(color: cars ? color : color.highlight)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            layoutSubviews()
        }
    }
    
    // MARK: StatusView
    var status: Status = Status() {
        didSet {
            layoutSubviews()
        }
    }
}
