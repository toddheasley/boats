import UIKit

class IndexViewController: ViewController {
    private let timeView: TimeView = TimeView()
    
    // MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timeView.frame = view.bounds
        view.addSubview(timeView)
    }
    
    override func transitionMode(duration: TimeInterval) {
        super.transitionMode(duration: duration)
        timeView.transitionMode(duration: duration)
    }
}
