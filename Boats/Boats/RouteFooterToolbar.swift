import UIKit
import BoatsKit

class RouteFooterToolbar: Toolbar {
    private let providerView: ProviderView = ProviderView()
    private let iconView: IconView = IconView(icon: .menu)
    
    var provider: Provider? {
        set {
            providerView.provider = newValue
        }
        get {
            return providerView.provider
        }
    }
    
    @objc func handleProviderAction(_ sender: AnyObject?) {
        if let url = (sender as? ProviderView)?.provider?.url {
            delegate?.toolbar?(self, didOpen: url)
        }
    }
    
    @objc func handleIconAction(_ sender: AnyObject?) {
        delegate?.toolbarDidFinish?(self)
    }
    
    // MARK: Toolbar
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 22.0 + UIEdgeInsets.padding.size.height)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame.size.width = bounds.size.width - UIEdgeInsets.padding.size.width + 4.0
        contentView.frame.size.height = providerView.frame.size.height
        contentView.frame.origin.y = (intrinsicContentSize.height - contentView.frame.size.height) / 2.0
        
        iconView.frame.origin.x = contentView.bounds.size.width - iconView.frame.size.width
        providerView.frame.size.width = iconView.frame.origin.x - UIEdgeInsets.padding.right
    }
    
    override func setUp() {
        super.setUp()
        
        separatorPosition = .top
        
        providerView.addTarget(self, action: #selector(handleProviderAction(_:)), for: .touchUpInside)
        providerView.isEnabled = true
        contentView.addSubview(providerView)
        
        iconView.addTarget(self, action: #selector(handleIconAction(_:)), for: .touchUpInside)
        iconView.isEnabled = true
        contentView.addSubview(iconView)
        
        transitionMode(duration: 0.0)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        
        providerView.transitionMode(duration: duration)
        iconView.transitionMode(duration: duration)
    }
}
