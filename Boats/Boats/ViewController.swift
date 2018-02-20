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
        NotificationCenter.default.addObserver(self, selector: #selector(handleModeChange), name: Notification.Name.ModeChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTimeChange), name: Notification.Name.TimeChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.ModeChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.TimeChange, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transitionMode(duration: 0.0)
    }
    
    // MARK: ModeTransitioning
    func transitionMode(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.view.backgroundColor = .background
        }
        setNeedsStatusBarAppearanceUpdate()
    }
}
