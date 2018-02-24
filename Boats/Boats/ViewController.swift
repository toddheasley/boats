import UIKit

class ViewController: UIViewController, ModeTransitioning {
    @objc func handleModeChange() {
        transitionMode(duration: 1.0)
    }
    
    @objc func handleTimeChange() {
        
    }
    
    // MARK: UIViewController
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return mode.statusBarStyle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        transitionMode(duration: 0.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleModeChange), name: Notification.Name.ModeChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeChange), name: Notification.Name.TimeChange, object: nil)
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.view.backgroundColor = .background
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
