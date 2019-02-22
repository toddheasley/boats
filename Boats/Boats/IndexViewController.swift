import UIKit
import BoatsKit

class IndexViewController: UIViewController {
    private let timetableView: TimetableView = TimetableView()
    
    // MARK: UIViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        URLSession.shared.index { index, error in
            guard let index: Index = index else {
                return
            }
            self.timetableView.timetable = index.routes.first?.schedule()?.timetable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .background
        
        timetableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        timetableView.frame = view.bounds
        view.addSubview(timetableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
