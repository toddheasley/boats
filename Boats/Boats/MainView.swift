import UIKit
import BoatsKit

protocol MainViewDelegate {
    func mainView(_ view: MainView, didOpen url: URL)
    func mainView(_ view: MainView, didSelect route: Route)
    func mainViewDidOpenList(_ view: MainView)
    func mainViewDidRefresh(_ view: MainView)
}

class MainView: UIView, UIScrollViewDelegate {
    let scrollView: UIScrollView = UIScrollView()
    let contentView: UIView = UIView()
    var delegate: MainViewDelegate?
    
    var index: Index = Index() {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    var contentInset: UIEdgeInsets = .zero {
        didSet {
            guard contentInset != oldValue else {
                return
            }
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: UIView
    override var contentRect: CGRect {
        var contentRect: CGRect = super.contentRect
        contentRect.size.width -= (contentInset.left + contentInset.right)
        contentRect.size.height -= (contentInset.top + contentInset.bottom)
        contentRect.origin.x += contentInset.left
        contentRect.origin.y += contentInset.top
        return contentRect
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollView.contentSize.width = scrollView.bounds.size.width
        scrollView.contentSize.height = contentView.frame.size.height + (bounds.size.height - contentRect.size.height)
        #if targetEnvironment(macCatalyst)
        scrollView.verticalScrollIndicatorInsets.top = 0.0 - safeAreaInsets.top
        #endif
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .background
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = bounds
        addSubview(scrollView)
        
        scrollView.addSubview(contentView)
    }
        
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
