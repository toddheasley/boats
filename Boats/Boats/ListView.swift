import UIKit
import BoatsKit
import BoatsBot

protocol ListViewDelegate {
    func listView(_ view: ListView, didSelect route: Route)
}

class ListView: UIView {
    var delegate: ListViewDelegate?
    
    var index: Index? {
        didSet {
            for subview in contentView.subviews {
                subview.removeFromSuperview()
            }
            for route in index?.routes ?? [] {
                let routeControl: RouteControl = RouteControl(route: route)
                routeControl.addTarget(self, action: #selector(handleRoute(control:)), for: .touchUpInside)
                routeControl.autoresizingMask = [.flexibleWidth]
                routeControl.frame.size.width = contentView.bounds.size.width
                routeControl.isHighlighted = route == index?.route
                contentView.addSubview(routeControl)
            }
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
    
    @objc func handleRoute(control: UIControl) {
        guard let route: Route = (control as? RouteControl)?.route else {
            return
        }
        index?.current = route
        delegate?.listView(self, didSelect: route)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: UIView = UIView()
    private let headerView: UIView = UIView()
    private let headerContentView: UIView = UIView()
    private let descriptionView: DescriptionView = DescriptionView()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentView.bounds.size
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height: CGFloat = descriptionView.frame.origin.y + descriptionView.frame.size.height + contentView.layer.borderWidth
        for (index, subview) in contentView.subviews.enumerated() {
            guard let subview: RouteControl = subview as? RouteControl else {
                continue
            }
            subview.frame.size.height = subview.intrinsicContentSize.height
            subview.frame.origin.y = height + ((subview.frame.size.height + contentView.layer.borderWidth) * CGFloat(index))
        }
        if let last: CGRect = contentView.subviews.last?.frame {
            contentView.frame.size.height = last.origin.y + last.size.height + contentView.layer.borderWidth
        }
        contentView.layer.borderColor = UIColor.foreground.cgColor
        contentView.isHidden = (index?.routes ?? []).isEmpty
        
        let a: CGFloat = contentView.frame.origin.y + height + max(contentOffset.y - frame.origin.y, 0.0)
        let b: CGFloat = (contentView.frame.origin.y + contentView.frame.size.height) - (contentView.subviews.last?.frame.size.height ?? (contentView.layer.cornerRadius * 2.0))
        headerView.frame.size.height = min(a, b)
        headerView.frame.origin.y = 0.0
        headerView.isHidden = contentView.isHidden
        
        headerContentView.frame.size = contentView.frame.size
        headerContentView.frame.origin.x = contentView.frame.origin.x
        headerContentView.frame.origin.y = headerView.frame.size.height - height
        headerContentView.layer.borderColor = contentView.layer.borderColor
        
        descriptionView.frame.size.width = contentView.bounds.size.width
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        
        contentView.clipsToBounds = true
        contentView.backgroundColor = .foreground
        contentView.autoresizingMask = [.flexibleWidth]
        contentView.frame.size.width = bounds.size.width
        contentView.layer.cornerCurve = .continuous
        contentView.layer.cornerRadius = 19.0
        contentView.layer.borderWidth = 2.0
        addSubview(contentView)
        
        headerView.clipsToBounds = true
        headerView.backgroundColor = .background
        headerView.autoresizingMask = [.flexibleWidth]
        headerView.frame.size.width = bounds.size.width
        addSubview(headerView)
        
        headerContentView.clipsToBounds = true
        headerContentView.backgroundColor = .foreground
        headerContentView.layer.cornerCurve = contentView.layer.cornerCurve
        headerContentView.layer.cornerRadius = contentView.layer.cornerRadius
        headerContentView.layer.borderWidth = contentView.layer.borderWidth
        headerView.addSubview(headerContentView)
        
        descriptionView.text = "Routes"
        descriptionView.frame.origin.y = contentView.layer.borderWidth
        descriptionView.frame.size.height = 42.0
        headerContentView.addSubview(descriptionView)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
        
        backgroundColor = .background(highlighted: true)
        label.textColor = .label
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
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let aspectRatio: CGSize = CGSize(width: 5.9, height: 1.0)
    private let label: UILabel = UILabel()
    private let carView: CarView = CarView()
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.size.width, height: frame.size.width / aspectRatio.width)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = isHighlighted ? .foreground : .background(highlighted: true)
        
        label.isUserInteractionEnabled = false
        label.font = .systemFont(ofSize: label.bounds.size.height * 0.9, weight: .bold)
        label.textColor = .label(highlighted: isHighlighted)
        label.frame.size.width = bounds.size.width - (label.frame.origin.x * 2.0)
        label.frame.size.height = (label.frame.size.width / 9.12) - 2.0
        label.frame.origin.y = (bounds.size.height - label.frame.size.height) / 2.0
        
        carView.isUserInteractionEnabled = false
        carView.frame.size.width = label.frame.size.height
        carView.frame.size.height = bounds.size.height
        carView.frame.origin.x = bounds.size.width - (carView.frame.size.width + label.frame.origin.x)
        carView.isCarFerry = route?.services.contains(.car) ?? false
        carView.isHighlighted = isHighlighted
        label.frame.size.width -= carView.isCarFerry ? carView.frame.size.width : 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(carView)
        
        label.numberOfLines = 1
        label.frame.origin.x = 9.0
        addSubview(label)
    }
}
