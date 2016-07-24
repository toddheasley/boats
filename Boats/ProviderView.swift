//
//  ProviderView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

@objc protocol ProviderViewDelegate {
    @objc optional func providerViewDidPop(view: ProviderView)
}

class ProviderView: UIView {
    private let popControl: PopControl = PopControl()
    weak var delegate: ProviderViewDelegate?
    
    var provider: Provider? {
        didSet {
            popControl.text = provider?.name
        }
    }
    
    func pop(sender: AnyObject?) {
        delegate?.providerViewDidPop?(view: self)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if (popControl.frame.contains(point)) {
            return true
        }
        return super.point(inside: point, with: event)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return popControl.intrinsicContentSize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        popControl.contentInset = UIEdgeInsets(top: 16.0, left: 11.0, bottom: 16.0, right: 11.0)
        popControl.frame.origin.x = 0.0 - popControl.contentInset.left - 10.0
        popControl.frame.origin.y = 0.0 - popControl.contentInset.top
        popControl.addTarget(self, action: #selector(pop(sender:)), for: .touchUpInside)
        addSubview(popControl)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
