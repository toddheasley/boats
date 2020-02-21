import WatchKit
import BoatsKit
import BoatsBot

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!
    
    var index: Index = Index() {
        didSet {
            setTitle(index.route?.name)
            let complications: [Complication] = index.complications()
            if !complications.isEmpty {
                table.setNumberOfRows(complications.count, withRowType: "Timetable")
                table.scrollToRow(at: 0)
                for (index, complication) in complications.enumerated() {
                    guard let controller: TimetableController = table.rowController(at: index) as? TimetableController else {
                        continue
                    }
                    controller.setComplication(complication, highlighted: index == 0)
                }
            } else {
                table.setNumberOfRows(1, withRowType: "Empty")
            }
        }
    }
}
