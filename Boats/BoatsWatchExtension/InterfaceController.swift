import WatchKit
import BoatsKit
import BoatsBot

class InterfaceController: WKInterfaceController {
    var index: Index = Index() {
        didSet {
            update()
        }
    }
    
    var route: Route {
        return index.current ?? index.routes.first!
    }
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    private let maxComplications: Int = 3
    
    private func update() {
        setTitle(route.name)
        let complications: [Complication] = index.complications()
        if !complications.isEmpty {
            table.setNumberOfRows(complications.count, withRowType: "Timetable")
            table.scrollToRow(at: 0)
            for (index, complication) in complications.enumerated() {
                guard let controller: TimetableController = table.rowController(at: index) as? TimetableController else {
                    continue
                }
                controller.setComplication(complication)
                controller.setHighlighted(index == 0)
            }
        } else {
            table.setNumberOfRows(1, withRowType: "Empty")
        }
    }
    
    // MARK: WKInterfaceController
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        (WKExtension.shared().delegate as? ExtensionDelegate)?.refresh()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        update()
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
}
