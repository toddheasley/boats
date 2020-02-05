import UIKit

class RefreshControl: UIControl {
    var isRefreshing: Bool {
        set {
            guard isAnimating != newValue else {
                return
            }
            isAnimating = newValue
            if isAnimating {
                feedbackGenerator?.impactOccurred()
                sendActions(for: .valueChanged)
            }
        }
        get {
            return isAnimating
        }
    }
    
    var contentOffset: CGPoint = .zero {
        didSet {
            if canRefresh, progress == 1.0 {
                canRefresh = false
                isRefreshing = true
            } else if progress > 0.0, feedbackGenerator == nil {
                feedbackGenerator = UIImpactFeedbackGenerator()
                feedbackGenerator?.prepare()
            } else if progress == 0.0 {
                feedbackGenerator = nil
                canRefresh = true
            }
        }
    }
    
    private var feedbackGenerator: UIImpactFeedbackGenerator?
    private var isAnimating: Bool = false
    private var canRefresh: Bool = false
    
    private var progress: CGFloat {
        return min(max(contentOffset.y / -88.0, 0.0), 1.0)
    }
}
