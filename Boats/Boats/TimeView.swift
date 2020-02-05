import UIKit
import BoatsKit

class TimeView: UIView {
    var isHighlighted: Bool = false {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var time: Time? {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    convenience init(time: Time) {
        self.init(frame: .zero)
        self.time = time
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let aspectRatio: CGSize = CGSize(width: 3.56, height: 1.0)
    private let contentView: UIView = UIView()
    private let hourLabel: (UILabel, UILabel) = (UILabel(), UILabel())
    private let separatorLabel: UILabel = UILabel()
    private let minuteLabel: (UILabel, UILabel) = (UILabel(), UILabel())
    private let periodLabel: UILabel = UILabel()
    
    // MARK: UIView
    override var accessibilityLabel: String? {
        set {
            super.accessibilityLabel = newValue
        }
        get {
            return super.accessibilityLabel ?? time?.description
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if frame.size.width / frame.size.height > aspectRatio.width {
            contentView.frame.size.width = frame.size.height * aspectRatio.width
            contentView.frame.size.height = frame.size.height
        } else {
            contentView.frame.size.width = frame.size.width
            contentView.frame.size.height = frame.size.width / aspectRatio.width
        }
        contentView.frame.origin.x = (bounds.size.width - contentView.frame.size.width) / 2.0
        contentView.frame.origin.y = (bounds.size.height - contentView.frame.size.height) / 2.0
        
        hourLabel.0.font = .monospacedDigitSystemFont(ofSize: contentView.bounds.size.height * 1.1, weight: .bold)
        hourLabel.0.textColor = .label(highlighted: isHighlighted)
        hourLabel.0.frame.size.width = contentView.bounds.size.width / 5.0
        hourLabel.0.frame.size.height = contentView.bounds.size.height
        
        hourLabel.1.font = hourLabel.0.font
        hourLabel.1.textColor = hourLabel.0.textColor
        hourLabel.1.frame.size = hourLabel.0.frame.size
        hourLabel.1.frame.origin.x = hourLabel.0.frame.size.width
        
        separatorLabel.font = hourLabel.0.font
        separatorLabel.textColor = hourLabel.0.textColor
        separatorLabel.frame.size.width = hourLabel.0.frame.size.width / 2.0
        separatorLabel.frame.size.height = hourLabel.0.frame.size.height
        separatorLabel.frame.origin.x = hourLabel.1.frame.origin.x + hourLabel.1.frame.size.width
        
        minuteLabel.0.font = hourLabel.0.font
        minuteLabel.0.textColor = hourLabel.0.textColor
        minuteLabel.0.frame.size = hourLabel.0.frame.size
        minuteLabel.0.frame.origin.x = separatorLabel.frame.origin.x + separatorLabel.frame.size.width
        
        minuteLabel.1.textColor = hourLabel.0.textColor
        periodLabel.textColor = hourLabel.0.textColor
        minuteLabel.1.font = hourLabel.0.font
        minuteLabel.1.frame.size = hourLabel.0.frame.size
        minuteLabel.1.frame.origin.x = minuteLabel.0.frame.origin.x + minuteLabel.0.frame.size.width
        
        periodLabel.font = hourLabel.0.font
        periodLabel.textColor = hourLabel.0.textColor
        periodLabel.frame.size = separatorLabel.frame.size
        periodLabel.frame.origin.x = contentView.bounds.size.width - periodLabel.frame.size.width
        
        hourLabel.0.text = time?.descriptionComponents[0]
        hourLabel.1.text = time?.descriptionComponents[1]
        separatorLabel.text = time?.descriptionComponents[2]
        minuteLabel.0.text = time?.descriptionComponents[3]
        minuteLabel.1.text = time?.descriptionComponents[4]
        periodLabel.text = time?.descriptionComponents[5]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.clipsToBounds = true
        addSubview(contentView)

        hourLabel.0.textAlignment = .center
        contentView.addSubview(hourLabel.0)
        
        hourLabel.1.textAlignment = .center
        contentView.addSubview(hourLabel.1)
        
        separatorLabel.textAlignment = .center
        contentView.addSubview(separatorLabel)
        
        minuteLabel.0.textAlignment = .center
        contentView.addSubview(minuteLabel.0)
        
        minuteLabel.1.textAlignment = .center
        contentView.addSubview(minuteLabel.1)
        
        periodLabel.textAlignment = .center
        contentView.addSubview(periodLabel)
    }
}
