import UIKit

extension UIViewController {
    @objc func viewDidChangeAppearance() {
        setNeedsStatusBarAppearanceUpdate()
        view.updateAppearance()
        for subview in view.subviews {
            subview.updateAppearance()
        }
    }
    
    @objc func setNeedsAppearanceUpdates() {
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidChangeAppearance), name: UIScreen.brightnessDidChangeNotification, object: nil)
        viewDidChangeAppearance()
    }
}
