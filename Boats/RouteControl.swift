//
//  RouteControl.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit

class RouteControl: UIControl {
    private let highlightView: UIView = UIView()
    private let label: UILabel = UILabel()
    
    var text: String? {
        didSet {
            label.text = text ?? ""
        }
    }
    
    var subtext: String? {
        didSet {
            
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            highlightView.isHidden = isHighlighted
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = suggestedFrame.size.width
        label.frame.origin.x = suggestedFrame.origin.x
        
        
        
        backgroundColor = .background
        highlightView.backgroundColor = .highlight
        label.textColor = .foreground(status: .past)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        highlightView.frame = bounds
        highlightView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        highlightView.isUserInteractionEnabled = false
        addSubview(highlightView)
        
        label.font = .small
        label.frame.size.height = bounds.size.height
        label.autoresizingMask = [.flexibleHeight]
        label.isUserInteractionEnabled = false
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
