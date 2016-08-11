//
//  CarsView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class CarsView: UIImageView, StatusView {
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
        
        let color: UIColor = .foreground(status: status)
        image = UIImage(named: "Cars")?.color(cars ? color : color.disabled)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFit
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: StatusView
    var status: Status = .past {
        didSet {
            layoutSubviews()
        }
    }
}
