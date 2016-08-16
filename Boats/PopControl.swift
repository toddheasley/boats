//
//  PopControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class PopControl: UIControl {
    private let popView: PopView = PopView()
    
    override var isHighlighted: Bool {
        didSet {
            popView.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return popView.frame.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        popView.frame.size = popView.intrinsicContentSize
        popView.frame.origin.x = (bounds.size.width - popView.frame.size.width) / 2.0
        popView.frame.origin.y = (bounds.size.height - popView.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        popView.contentMode = .scaleAspectFit
        addSubview(popView)
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PopView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image = UIImage(named: "Pop")?.color(.control)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 22.0, height: 14.0)
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
