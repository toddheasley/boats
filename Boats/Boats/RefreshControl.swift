import UIKit

class RefreshControl: UIRefreshControl {
    
    // MARK: UIRefreshControl
    override func endRefreshing() {
        super.endRefreshing()
    }
    
    override func updateAppearance() {
        super.updateAppearance()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.first?.isHidden = true
        
        // trigger height ~200.0
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
