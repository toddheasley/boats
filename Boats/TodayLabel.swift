//
//  TodayLabel.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

class TodayLabel: UIView {
    private let label: UILabel = UILabel()
    private let sublabel: UILabel = UILabel()
    
    var holiday: Holiday? {
        didSet {
            label.text = DateFormatter.shared.string(from: Foundation.Date())
            sublabel.text = holiday?.name ?? ""
            
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (suggestedSizeClass.horizontal == .compact) {
            sublabel.font = .small
            sublabel.sizeToFit()
            sublabel.frame.size.width = bounds.size.width
            sublabel.frame.origin.x = 0.0
            sublabel.frame.origin.y = bounds.size.height - sublabel.frame.size.height
            
            label.font = UIFont.xlarge.withSize(32.0)
            label.sizeToFit()
            label.frame.size.width = bounds.size.width
            label.frame.origin.x = 0.0
            label.frame.origin.y = sublabel.frame.origin.y - label.frame.size.height
        } else {
            label.font = .xlarge
            label.sizeToFit()
            label.frame.origin.x = (sublabel.text!.isEmpty) ? 0.0 : bounds.size.width - (label.frame.width + 2.0)
            label.frame.origin.y = bounds.size.height - label.frame.size.height
            
            sublabel.font = label.font
            sublabel.frame.size.width = label.frame.origin.x
            sublabel.frame.size.height = label.frame.size.height
            sublabel.frame.origin.y = label.frame.origin.y
        }
        label.textColor = .foreground
        sublabel.textColor = label.textColor
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240.0, height: (suggestedSizeClass.horizontal == .compact) ? 72.0 : 31.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        addSubview(label)
        addSubview(sublabel)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
