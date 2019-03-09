import UIKit
import BoatsKit

protocol IndexViewDelegate {
    func openIndex(view: IndexView, route: Route)
}

class IndexView: UIView {
    var delegate: IndexViewDelegate?
    
    var index: Index = Index() {
        didSet {
            for subview in contentView.subviews {
                subview.removeFromSuperview()
            }
            for route in index.routes {
                let routeControl: RouteControl = RouteControl(route: route)
                routeControl.addTarget(self, action: #selector(handleRoute(_:)), for: .touchUpInside)
                contentView.addSubview(routeControl)
            }
            updateAppearance()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var contentOffset: CGPoint = .zero {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var highlighted: Route? {
        for subview in contentView.subviews {
            guard (subview as? RouteControl)?.isHighlighted ?? false else {
                continue
            }
            return (subview as? RouteControl)?.route
        }
        return nil
    }
    
    @discardableResult func highlight(route: Route? = nil) -> CGRect? {
        guard let route: Route = route ?? highlighted else {
            return nil
        }
        clearHighlighted()
        for subview in contentView.subviews {
            guard let routeControl: RouteControl = subview as? RouteControl, routeControl.route == route else {
                continue
            }
            routeControl.isHighlighted = true
            var frame: CGRect = routeControl.frame
            frame.origin.x += contentView.frame.origin.x
            frame.origin.y += contentView.frame.origin.y
            return frame
        }
        return nil
    }
    
    func clearHighlighted() {
        for subview in contentView.subviews {
            (subview as? RouteControl)?.isHighlighted = false
        }
    }
    
    @objc func handleRoute(_ sender: AnyObject?) {
        guard let route: Route = (sender as? RouteControl)?.route else {
            return
        }
        delegate?.openIndex(view: self, route: route)
    }
    
    private let contentView: UIView = UIView()
    private let headerView: UIView = UIView()
    private let headerContentView: UIView = UIView()
    private let descriptionView: DescriptionView = DescriptionView()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: contentView.frame.size.width + (.edgeInset * 2.0), height: contentView.frame.size.height + (.edgeInset * 2.0))
    }
    
    override var frame: CGRect {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        backgroundColor = .background
        headerView.backgroundColor = backgroundColor
        
        contentView.backgroundColor = .color
        contentView.layer.borderColor = .color
        
        headerContentView.backgroundColor = contentView.backgroundColor
        headerContentView.layer.borderColor = contentView.layer.borderColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.size.width = min(bounds.size.width - (.edgeInset * 2.0), .maxWidth)
        
        descriptionView.frame.size.width = contentView.bounds.size.width
        
        let height: CGFloat = descriptionView.frame.origin.y + descriptionView.frame.size.height + .borderWidth
        for (index, subview) in contentView.subviews.enumerated() {
            guard let subview: RouteControl = subview as? RouteControl else {
                continue
            }
            subview.frame.size.width = contentView.bounds.size.width
            subview.frame.size.height = subview.intrinsicContentSize.height
            subview.frame.origin.y = height + ((subview.frame.size.height + contentView.layer.borderWidth) * CGFloat(index))
        }
        
        if let last: CGRect = contentView.subviews.last?.frame {
            contentView.frame.size.height = last.origin.y + last.size.height + contentView.layer.borderWidth
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        contentView.isHidden = index.routes.isEmpty
        
        let a: CGFloat = contentView.frame.origin.y + height + max(contentOffset.y - frame.origin.y, 0.0)
        let b: CGFloat = (contentView.frame.origin.y + contentView.frame.size.height) - (contentView.subviews.last?.frame.size.height ?? (.cornerRadius * 2.0))
        headerView.frame.size.height = min(a, b)
        headerView.frame.origin.y = 0.0
        headerView.isHidden = contentView.isHidden
        
        headerContentView.frame.size = contentView.frame.size
        headerContentView.frame.origin.x = contentView.frame.origin.x
        headerContentView.frame.origin.y = headerView.frame.size.height - height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = .borderWidth
        contentView.layer.cornerRadius = .cornerRadius
        addSubview(contentView)
        
        headerView.clipsToBounds = true
        headerView.autoresizingMask = [.flexibleWidth]
        headerView.frame.size.width = bounds.size.width
        addSubview(headerView)
        
        headerContentView.clipsToBounds = true
        headerContentView.layer.borderWidth = contentView.layer.borderWidth
        headerContentView.layer.cornerRadius = contentView.layer.cornerRadius
        headerView.addSubview(headerContentView)
        
        descriptionView.text = "Routes"
        descriptionView.frame.origin.y = contentView.layer.borderWidth
        descriptionView.frame.size.height = 42.0
        headerContentView.addSubview(descriptionView)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class DescriptionView: UIView {
    var text: String? {
        set {
            label.text = newValue
        }
        get {
            return label.text
        }
    }
    
    private let label: UILabel = UILabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return label.sizeThatFits(.zero)
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        backgroundColor = .background
        label.textColor = .color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .systemFont(ofSize: 21.0, weight: .bold)
        label.numberOfLines = 1
        label.autoresizingMask = [.flexibleHeight]
        label.frame.size.height = bounds.size.height
        label.frame.origin.x = 9.0
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate class RouteControl: UIControl {
    private(set) var route: Route?
    
    convenience init(route: Route) {
        self.init(frame: .zero)
        self.route = route
        label.text = route.name
    }
    
    private let label: UILabel = UILabel()
    private let carView: CarView = CarView()
    private let aspectRatio: CGSize = CGSize(width: 6.5, height: 1.0)
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.size.width, height: frame.size.width / aspectRatio.width)
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        backgroundColor = isHighlighted ? .color : .background
        label.textColor = isHighlighted ? .background : .color
        carView.tintColor = label.textColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: label.bounds.size.height * 0.9, weight: .bold)
        print("*** \(label.font.pointSize)")
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
        label.frame.size.height = (label.frame.size.width / 9.12) - .borderWidth
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
        
        carView.isUserInteractionEnabled = false
        carView.frame.size.width = label.frame.size.height
        carView.frame.size.height = bounds.size.height
        carView.frame.origin.x = bounds.size.width - (carView.frame.size.width + label.frame.origin.x)
        carView.isCarFerry = route?.services.contains(.car) ?? false
        label.frame.size.width -= carView.isCarFerry ? carView.frame.size.width : 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(carView)
        
        label.numberOfLines = 1
        label.frame.origin.x = 9.0
        addSubview(label)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
