import UIKit

enum Icon: String {
    case menu
    case car
    
    var path: UIBezierPath {
        switch self {
        case .menu:
            let path: UIBezierPath = UIBezierPath()
            path.append(UIBezierPath(roundedRect: CGRect(x: 5.0, y: 9.0, width: 3.0, height: 3.0), cornerRadius: 0.5))
            path.append(UIBezierPath(roundedRect: CGRect(x: 5.0, y: 15.0, width: 3.0, height: 3.0), cornerRadius: 0.5))
            path.append(UIBezierPath(roundedRect: CGRect(x: 5.0, y: 21.0, width: 3.0, height: 3.0), cornerRadius: 0.5))
            path.append(UIBezierPath(roundedRect: CGRect(x: 11.0, y: 9.75, width: 16.0, height: 1.5), cornerRadius: 0.5))
            path.append(UIBezierPath(roundedRect: CGRect(x: 11.0, y: 15.75, width: 16.0, height: 1.5), cornerRadius: 0.5))
            path.append(UIBezierPath(roundedRect: CGRect(x: 11.0, y: 21.75, width: 16.0, height: 1.5), cornerRadius: 0.5))
            return path
        case .car:
            let subpath: UIBezierPath = UIBezierPath()
            subpath.move(to: CGPoint(x: 7.5, y: 14.5))
            subpath.addLine(to: CGPoint(x: 8.5, y: 9.5))
            subpath.addQuadCurve(to: CGPoint(x: 10.5, y: 7.75), controlPoint: CGPoint(x: 8.5, y: 7.5))
            subpath.addLine(to: CGPoint(x: 21.5, y: 7.75))
            subpath.addQuadCurve(to: CGPoint(x: 23.5, y: 9.5), controlPoint: CGPoint(x: 23.0, y: 7.5))
            subpath.addLine(to: CGPoint(x: 24.5, y: 14.5))
            subpath.close()
            
            let path: UIBezierPath = UIBezierPath()
            path.move(to: CGPoint(x: 5.5, y: 14.5))
            path.addLine(to: CGPoint(x: 7.0, y: 8.0))
            path.addQuadCurve(to: CGPoint(x: 10.0, y: 6.0), controlPoint: CGPoint(x: 7.5, y: 6.0))
            path.addLine(to: CGPoint(x: 22.0, y: 6.0))
            path.addQuadCurve(to: CGPoint(x: 25.0, y: 8.0), controlPoint: CGPoint(x: 24.5, y: 6.0))
            path.addLine(to: CGPoint(x: 26.5, y: 14.5))
            path.close()
            path.append(UIBezierPath(roundedRect: CGRect(x: 4.0, y: 14.0, width: 24.0, height: 10.0), cornerRadius: 2.0))
            path.append(UIBezierPath(roundedRect: CGRect(x: 4.75, y: 23.0, width: 4.0, height: 4.0), cornerRadius: 1.0))
            path.append(UIBezierPath(roundedRect: CGRect(x: 23.25, y: 23.0, width: 4.0, height: 4.0), cornerRadius: 1.0))
            path.append(subpath.reversing())
            path.append(UIBezierPath(ovalIn: CGRect(x: 6.0, y: 17.0, width: 4.0, height: 4.0)).reversing())
            path.append(UIBezierPath(ovalIn: CGRect(x: 22.0, y: 17.0, width: 4.0, height: 4.0)).reversing())
            return path
        }
    }
}

class IconView: UIControl, ModeTransitioning {
    private let shapeLayer: CAShapeLayer = CAShapeLayer()
    
    var icon: Icon? {
        didSet {
            layoutSubviews()
        }
    }
    
    convenience init(icon: Icon) {
        self.init(frame: .zero)
        self.icon = icon
    }
    
    // MARK: UIControl
    override var isHighlighted: Bool {
        set {
            super.isHighlighted = newValue
            shapeLayer.backgroundColor = isHighlighted ? UIColor.tint.cgColor: nil
        }
        get {
            return super.isHighlighted
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 24.0, height: 32.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: max(newValue.size.width, intrinsicContentSize.width), height: max(newValue.size.height, intrinsicContentSize.height))
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.cornerRadius = .cornerRadius
        shapeLayer.frame.origin.x = (bounds.size.width - shapeLayer.frame.size.width) / 2.0
        shapeLayer.frame.origin.y = (bounds.size.height - shapeLayer.frame.size.height) / 2.0
        shapeLayer.path = icon?.path.cgPath
    }
    
    override func setUp() {
        super.setUp()
        
        isEnabled = false
        
        shapeLayer.frame.size = CGSize(width: intrinsicContentSize.height, height: intrinsicContentSize.height)
        layer.addSublayer(shapeLayer)
        
        transitionMode(duration: 0.0)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
        setUp()
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        shapeLayer.fillColor = UIColor.text.cgColor
    }
}
