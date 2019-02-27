import UIKit
import BoatsKit

class IndexViewController: UIViewController, UIScrollViewDelegate {
    func refresh() {
        
    }
    
    private let scrollView: UIScrollView = UIScrollView()
    
    // MARK: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard presentedViewController == nil,
            let routeViewController: RouteViewController = RouteViewController(route: "peaks-island") else {
            return
        }
        present(routeViewController, animated: animated, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .background
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = view.safeAreaInsets
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.frame = view.bounds
        scrollView.alwaysBounceVertical = true
        scrollView.contentSize.height = 6000.0
        view.addSubview(scrollView)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
