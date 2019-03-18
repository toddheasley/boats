import WatchKit
import BoatsKit

class EmptyController: NSObject {
    @IBOutlet weak var label: WKInterfaceLabel! {
        didSet {
            label.setText("Schedule Unavailable")
            label.setTextColor(.background())
        }
    }
}
