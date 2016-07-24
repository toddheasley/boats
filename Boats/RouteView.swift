//
//  RouteView.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import UIKit
import BoatsData

@objc protocol RouteViewDelegate {
    @objc optional func routeViewCanExpand(view: RouteView, animated: Bool) -> Bool
    @objc optional func routeViewDidExpand(view: RouteView)
    func routeViewFrame(view: RouteView, expanded: Bool) -> CGRect
}

class RouteView: UIView, UIScrollViewDelegate {
    private let animationDuration: TimeInterval = 0.25
    private let scale: CGFloat = 0.8
    private(set) var expanded: Bool = false
    var routeControl: RouteControl = RouteControl()
    var scrollView: UIScrollView = UIScrollView()
    var scrollViewBorder: CALayer = CALayer()
    var route: Route?
    var page: (index: Int, count: Int) = (0, 1)
    weak var delegate: RouteViewDelegate?
    
    func expand(sender: AnyObject?) {
        if (!expanded) {
            expand()
        }
    }
    
    func expand(animated: Bool = true) {
        guard let delegate = delegate else {
            return
        }
        if let canExpand = delegate.routeViewCanExpand?(view: self, animated: animated) , !canExpand {
            return
        }
        expanded = true
        let frame = delegate.routeViewFrame(view: self, expanded: true)
        if (!animated) {
            self.frame = frame
            delegate.routeViewDidExpand?(view: self)
            return
        }
        UIView.animate(withDuration: animationDuration, animations: {
            self.frame = frame
        }, completion: { completed in
            delegate.routeViewDidExpand?(view: self)
        })
    }
    
    func collapse(animated: Bool = true) {
        guard let delegate = delegate else {
            return
        }
        expanded = false
        let frame = delegate.routeViewFrame(view: self, expanded: false)
        if (!animated) {
            self.frame = frame
            return
        }
        UIView.animate(withDuration: (animationDuration * 0.75), animations: {
            self.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0)
            self.layer.opacity = 0.0
        }, completion: { finished in
            self.layer.opacity = 1.0
            self.layer.transform = CATransform3DIdentity
            self.frame = frame
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.isHidden = scrollView.frame.size.height < 100.0
        
        scrollViewBorder.frame = CGRect(x: -0.5, y: 0.0, width: scrollView.bounds.size.width + 1.0, height: scrollView.bounds.size.height)
        scrollViewBorder.borderColor = UIColor.foreground.disabled.cgColor
        scrollView.backgroundColor = .background
        scrollView.contentSize.width = scrollView.bounds.size.width * CGFloat(page.count)
        scrollView.contentSize.height = scrollView.bounds.size.height
        scrollViewDidEndDecelerating(scrollView)
        
        bringSubview(toFront: routeControl)
        routeControl.isHidden = expanded
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.frame = bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        addSubview(scrollView)
        
        scrollViewBorder.borderWidth = 0.5
        scrollView.layer.addSublayer(scrollViewBorder)
        
        routeControl.frame = bounds
        routeControl.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        routeControl.addTarget(self, action: #selector(expand(sender:)), for: .touchUpInside)
        addSubview(routeControl)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        page.index = (scrollView.bounds.size.width > 0) ? min(Int(ceil(scrollView.contentOffset.x / scrollView.bounds.size.width)), page.count - 1) : 0
        scrollView.setContentOffset(CGPoint(x: (scrollView.bounds.size.width * CGFloat(page.index)), y: 0.0), animated: true)
    }
}
