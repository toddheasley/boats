import UIKit
import SafariServices
import BoatsKit
import BoatsBot

class MainViewController: UIViewController, MainViewDelegate {
    private(set) var index: Index {
        set {
            indexView.index = newValue
            routeView.index = newValue
        }
        get {
            return indexView.index
        }
    }
    
    @IBAction func reload() {
        refresh(cache: 0.0)
    }
    
    @IBAction func debug() {
        guard let action: URLSession.Action = URLSession.Action("/Users/toddheasley/Documents/Boats/boats-web") else {
            return
        }
        URLSession.shared.index(action: action) { index, _ in
            self.index = index ?? self.index
        }
        
    }
    
    func refresh(cache timeInterval: TimeInterval = 30.0) {
        URLSession.shared.index(cache: timeInterval) { index, _ in
            self.index = index ?? self.index
        }
    }
    
    private let routeView: RouteView = RouteView()
    private let indexView: IndexView = IndexView()
    
    // MARK: UIViewController
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if view.bounds.size.width > UIView.maximumContentWidth {
            indexView.isHidden = false
            
            routeView.frame.origin.x = indexView.frame.size.width - indexView.contentRect.origin.x
            routeView.frame.size.width = view.bounds.size.width - routeView.frame.origin.x
            routeView.isNavigationBarHidden = true
        } else {
            indexView.isHidden = true
            
            routeView.frame.size.width = view.bounds.size.width
            routeView.frame.origin.x = 0.0
            routeView.isNavigationBarHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        routeView.index = Index()
        routeView.delegate = self
        routeView.autoresizingMask = [.flexibleHeight]
        routeView.frame.size.height = view.bounds.size.height
        view.addSubview(routeView)
        
        indexView.index = Index()
        indexView.delegate = self
        indexView.autoresizingMask = [.flexibleHeight]
        indexView.frame.size.width = UIView.maximumContentWidth / 2.0
        indexView.frame.size.height = view.bounds.size.height
        view.addSubview(indexView)
        
        #if targetEnvironment(macCatalyst)
        addKeyCommand(UIKeyCommand(input: "d", modifierFlags: .command, action: #selector(debug)))
        #endif
    }
    
    // MARK: MainViewDelegate
    func mainView(_ view: MainView, didOpen url: URL) {
        let viewController: SFSafariViewController = SFSafariViewController(url: url)
        viewController.preferredBarTintColor = .background
        viewController.preferredControlTintColor = .label
        present(viewController, animated: true, completion: nil)
    }
    
    func mainView(_ view: MainView, didSelect route: Route) {
        index.current = route
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mainViewDidOpenList(_ view: MainView) {
        present(IndexViewController(index: index, delegate: self), animated: true, completion: nil)
    }
    
    func mainViewDidRefresh(_ view: MainView) {
        refresh(cache: 0.0)
    }
}
