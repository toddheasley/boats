//
//  PopControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class PopControl: UIControl, ModeView {
    private let view: UIImageView = UIImageView()
    
    override var isHighlighted: Bool {
        didSet {
            view.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 22.0, height: 14.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        view.frame.size = intrinsicContentSize
        view.frame.origin.x = (bounds.size.width - view.frame.size.width) / 2.0
        view.frame.origin.y = (bounds.size.height - view.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "Pop")?.tint(color: .control(mode: mode))
        addSubview(view)
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode = Mode() {
        didSet {
            view.image = UIImage(named: "Pop")?.tint(color: .control(mode: mode))
        }
    }
}
