import UIKit
import BoatsKit
import BoatsBot

protocol NavigationBarDelegate {
    func navigationBar(_ bar: NavigationBar, didOpen url: URL)
    func navigationBarDidOpenList(_ bar: NavigationBar)
    func navigationBarDidRefresh(_ bar: NavigationBar)
}

class NavigationBar: UIView {
    var delegate: NavigationBarDelegate?
    
    var index: Index = Index() {
        didSet {
            refreshControl.isRefreshing = false
            titleLabel.text = index.route?.name
            linkControl.text = index.name
            linkControl.url = index.url
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var contentOffset: CGPoint = .zero {
        didSet {
            refreshControl.contentOffset = contentOffset
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    @objc func handleRefresh(control: RefreshControl) {
        delegate?.navigationBarDidRefresh(self)
    }
    
    @objc func handleLink(control: LinkControl) {
        guard let url: URL = control.url else {
            return
        }
        delegate?.navigationBar(self, didOpen: url)
    }
    
    @objc func handleList(control: ListControl) {
        delegate?.navigationBarDidOpenList(self)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundView: UIView = UIView()
    private let backgroundSeparator: UIView = UIView()
    private let contentView: UIView = UIView()
    private let refreshControl: RefreshControl = RefreshControl()
    private let listControl: ListControl = ListControl()
    private let linkControl: LinkControl = LinkControl()
    private let titleLabel: TitleLabel = TitleLabel()
    
    // MARK: UIView
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width, height: 104.0)
    }
    
    override var frame: CGRect {
        set {
            super.frame = CGRect(x: newValue.origin.x, y: newValue.origin.y, width: newValue.size.width, height: 52.0)
        }
        get {
            return super.frame
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.frame.size.height = frame.size.height + frame.origin.y
        backgroundView.frame.origin.y = 0.0 - frame.origin.y
        backgroundView.isHidden = contentOffset.y < (intrinsicContentSize.height - bounds.size.height)
        
        var contentRect: CGRect = self.contentRect
        contentRect.size.height = max(intrinsicContentSize.height - contentOffset.y, bounds.size.height)
        contentRect.origin.y = 0.0
        contentView.frame = contentRect
        
        linkControl.frame.size.width = linkControl.intrinsicContentSize.width
        linkControl.alpha = 1.0 - (contentOffset.y * 0.2)
        
        titleLabel.frame.size.width = contentView.bounds.size.width - (contentOffset.y > 0.0 ? listControl.frame.size.width + (contentView.frame.origin.x * 0.5) : 0.0)
        titleLabel.frame.origin.x = 0.0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = false
        
        backgroundView.backgroundColor = .background(highlighted: true)
        backgroundView.autoresizingMask = [.flexibleWidth]
        backgroundView.frame.size.width = bounds.size.width
        addSubview(backgroundView)
        
        backgroundSeparator.backgroundColor = .foreground
        backgroundSeparator.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        backgroundSeparator.frame.size.width = backgroundView.bounds.size.width
        backgroundSeparator.frame.size.height = 2.0
        backgroundSeparator.frame.origin.y = backgroundView.bounds.size.height
        backgroundView.addSubview(backgroundSeparator)
        
        addSubview(contentView)
        
        refreshControl.addTarget(self, action: #selector(handleRefresh(control:)), for: .valueChanged)
        
        listControl.addTarget(self, action: #selector(handleList(control:)), for: .touchUpInside)
        listControl.autoresizingMask = [.flexibleLeftMargin]
        listControl.frame.size.width = listControl.intrinsicContentSize.width
        listControl.frame.size.height = bounds.size.height
        listControl.frame.origin.x = contentView.bounds.size.width - listControl.frame.size.width
        contentView.addSubview(listControl)
        
        linkControl.addTarget(self, action: #selector(handleLink(control:)), for: .touchUpInside)
        linkControl.frame.size.height = bounds.size.height
        contentView.addSubview(linkControl)
        
        titleLabel.autoresizingMask = [.flexibleTopMargin]
        titleLabel.frame.size.height = bounds.size.height
        titleLabel.frame.origin.y = contentView.bounds.size.height - titleLabel.frame.size.height
        contentView.addSubview(titleLabel)
    }
}
