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
            let path: UIBezierPath = UIBezierPath()
            path.move(to: CGPoint(x: 24.0, y: 14.25))
            path.addCurve(to: CGPoint(x: 25.5, y: 17.0), controlPoint1: CGPoint(x: 25.0, y: 14.75), controlPoint2: CGPoint(x: 25.5, y: 15.75))
            path.addCurve(to: CGPoint(x: 25.5, y: 17.0), controlPoint1: CGPoint(x: 25.5, y: 17.0), controlPoint2: CGPoint(x: 25.5, y: 17.0))
            path.addLine(to: CGPoint(x: 25.5, y: 21.5))
            path.addCurve(to: CGPoint(x: 24.0, y: 23.0), controlPoint1: CGPoint(x: 25.5, y: 22.25), controlPoint2: CGPoint(x: 24.75, y: 23.0))
            path.addCurve(to: CGPoint(x: 22.5, y: 21.5), controlPoint1: CGPoint(x: 23.25, y: 23.0), controlPoint2: CGPoint(x: 22.5, y: 22.25))
            path.addLine(to: CGPoint(x: 22.5, y: 20.5))
            path.addCurve(to: CGPoint(x: 22.0, y: 20.5), controlPoint1: CGPoint(x: 22.25, y: 20.5), controlPoint2: CGPoint(x: 22.25, y: 20.5))
            path.addLine(to: CGPoint(x: 10.0, y: 20.5))
            path.addCurve(to: CGPoint(x: 9.5, y: 20.5), controlPoint1: CGPoint(x: 9.75, y: 20.5), controlPoint2: CGPoint(x: 9.75, y: 20.5))
            path.addLine(to: CGPoint(x: 9.5, y: 21.5))
            path.addCurve(to: CGPoint(x: 8.0, y: 23.0), controlPoint1: CGPoint(x: 9.5, y: 22.25), controlPoint2: CGPoint(x: 8.75, y: 23.0))
            path.addCurve(to: CGPoint(x: 6.5, y: 21.5), controlPoint1: CGPoint(x: 7.25, y: 23.0), controlPoint2: CGPoint(x: 6.5, y: 22.25))
            path.addLine(to: CGPoint(x: 6.5, y: 17.0))
            path.addCurve(to: CGPoint(x: 6.5, y: 17.0), controlPoint1: CGPoint(x: 6.5, y: 17.0), controlPoint2: CGPoint(x: 6.5, y: 17.0))
            path.addCurve(to: CGPoint(x: 8.0, y: 14.25), controlPoint1: CGPoint(x: 6.5, y: 15.75), controlPoint2: CGPoint(x: 7.0, y: 14.75))
            path.addCurve(to: CGPoint(x: 8.25, y: 13.75), controlPoint1: CGPoint(x: 8.0, y: 14.0), controlPoint2: CGPoint(x: 8.0, y: 14.0))
            path.addLine(to: CGPoint(x: 10.0, y: 9.75))
            path.addCurve(to: CGPoint(x: 11.0, y: 9.0), controlPoint1: CGPoint(x: 10.25, y: 9.25), controlPoint2: CGPoint(x: 10.75, y: 9.0))
            path.addLine(to: CGPoint(x: 21.0, y: 9.0))
            path.addCurve(to: CGPoint(x: 22.0, y: 9.75), controlPoint1: CGPoint(x: 21.25, y: 9.0), controlPoint2: CGPoint(x: 21.75, y: 9.25))
            path.addLine(to: CGPoint(x: 23.75, y: 13.75))
            path.addCurve(to: CGPoint(x: 24.0, y: 14.25), controlPoint1: CGPoint(x: 24.0, y: 14.0), controlPoint2: CGPoint(x: 24.0, y: 14.25))
            path.close()
            path.move(to: CGPoint(x: 13.75, y: 16.5))
            path.addCurve(to: CGPoint(x: 13.0, y: 17.25), controlPoint1: CGPoint(x: 13.25, y: 16.5), controlPoint2: CGPoint(x: 13.0, y: 16.75))
            path.addCurve(to: CGPoint(x: 13.75, y: 18.0), controlPoint1: CGPoint(x: 13.0, y: 17.75), controlPoint2: CGPoint(x: 13.25, y: 18.0))
            path.addLine(to: CGPoint(x: 18.25, y: 18.0))
            path.addCurve(to: CGPoint(x: 19.0, y: 17.25), controlPoint1: CGPoint(x: 18.75, y: 18.0), controlPoint2: CGPoint(x: 19.0, y: 17.75))
            path.addCurve(to: CGPoint(x: 18.25, y: 16.5), controlPoint1: CGPoint(x: 19.0, y: 16.75), controlPoint2: CGPoint(x: 18.75, y: 16.5))
            path.addLine(to: CGPoint(x: 13.75, y: 16.5))
            path.close()
            path.move(to: CGPoint(x: 9.5, y: 18.25))
            path.addCurve(to: CGPoint(x: 10.75, y: 17.25), controlPoint1: CGPoint(x: 10.25, y: 18.25), controlPoint2: CGPoint(x: 10.75, y: 17.75))
            path.addCurve(to: CGPoint(x: 9.5, y: 16.0), controlPoint1: CGPoint(x: 10.75, y: 16.5), controlPoint2: CGPoint(x: 10.25, y: 16.0))
            path.addCurve(to: CGPoint(x: 8.5, y: 17.25), controlPoint1: CGPoint(x: 9.0, y: 16.0), controlPoint2: CGPoint(x: 8.5, y: 16.5))
            path.addCurve(to: CGPoint(x: 9.5, y: 18.25), controlPoint1: CGPoint(x: 8.5, y: 17.75), controlPoint2: CGPoint(x: 9.0, y: 18.25))
            path.close()
            path.move(to: CGPoint(x: 22.5, y: 18.25))
            path.addCurve(to: CGPoint(x: 23.5, y: 17.25), controlPoint1: CGPoint(x: 23.0, y: 18.25), controlPoint2: CGPoint(x: 23.5, y: 17.75))
            path.addCurve(to: CGPoint(x: 22.5, y: 16.0), controlPoint1: CGPoint(x: 23.5, y: 16.5), controlPoint2: CGPoint(x: 23.0, y: 16.0))
            path.addCurve(to: CGPoint(x: 21.25, y: 17.25), controlPoint1: CGPoint(x: 21.75, y: 16.0), controlPoint2: CGPoint(x: 21.25, y: 17.0))
            path.addCurve(to: CGPoint(x: 22.5, y: 18.25), controlPoint1: CGPoint(x: 21.25, y: 17.75), controlPoint2: CGPoint(x: 21.75, y: 18.25))
            path.close()
            path.move(to: CGPoint(x: 11.75, y: 10.0))
            path.addCurve(to: CGPoint(x: 11.0, y: 10.5), controlPoint1: CGPoint(x: 11.5, y: 10.0), controlPoint2: CGPoint(x: 11.0, y: 10.25))
            path.addLine(to: CGPoint(x: 9.75, y: 13.0))
            path.addCurve(to: CGPoint(x: 9.75, y: 13.5), controlPoint1: CGPoint(x: 9.75, y: 13.25), controlPoint2: CGPoint(x: 9.5, y: 13.5))
            path.addLine(to: CGPoint(x: 22.25, y: 13.5))
            path.addCurve(to: CGPoint(x: 22.25, y: 13.0), controlPoint1: CGPoint(x: 22.5, y: 13.5), controlPoint2: CGPoint(x: 22.25, y: 13.25))
            path.addLine(to: CGPoint(x: 21.0, y: 10.5))
            path.addCurve(to: CGPoint(x: 20.25, y: 10.0), controlPoint1: CGPoint(x: 21.0, y: 10.25), controlPoint2: CGPoint(x: 20.5, y: 10.0))
            path.addLine(to: CGPoint(x: 11.75, y: 10.0))
            path.close()
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
            shapeLayer.backgroundColor = isHighlighted ? UIColor.tint(.medium).cgColor : nil
        }
        get {
            return super.isHighlighted
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 32.0, height: 32.0)
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
        
        shapeLayer.frame.size = intrinsicContentSize
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
