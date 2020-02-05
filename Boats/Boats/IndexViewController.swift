import UIKit
import BoatsKit

class IndexViewController: UIViewController {
    var delegate: MainViewDelegate? {
        return indexView.delegate
    }
    
    @objc func handleDismiss(control: DismissControl) {
        dismiss(animated: true, completion: nil)
    }
    
    convenience init(index: Index, delegate: MainViewDelegate? = nil) {
        self.init()
        indexView.delegate = delegate
        indexView.index = index
    }
    
    private let indexView: IndexView = IndexView()
    private let dismissControl: DismissControl = DismissControl()
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        indexView.isLinkControlHidden = true
        indexView.contentInset.top = dismissControl.intrinsicContentSize.height
        indexView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indexView.frame = view.bounds
        view.addSubview(indexView)
        
        dismissControl.addTarget(self, action: #selector(handleDismiss(control:)), for: .touchUpInside)
        dismissControl.autoresizingMask = [.flexibleWidth]
        dismissControl.frame.size.width = view.bounds.size.width
        view.addSubview(dismissControl)
    }
}
