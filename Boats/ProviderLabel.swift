//
//  ProviderLabel.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class ProviderLabel: UILabel, ModeView {
    var provider: Provider? {
        didSet {
            guard let provider = provider else {
                text = ""
                return
            }
            text = "Operated by \(provider.name)"
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: frame.size.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = .regular
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

class ProviderControl: UIControl, ModeView {
    private let label: ProviderLabel = ProviderLabel()
    
    var provider: Provider? {
        set {
            label.provider = newValue
        }
        get {
            return label.provider
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            label.alpha = isHighlighted ? 0.5 : 1.0
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return label.intrinsicContentSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.isUserInteractionEnabled = false
        addSubview(label)
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ModeView
    var mode: Mode {
        set {
            label.mode = newValue
        }
        get {
            return label.mode
        }
    }
}
