import WatchKit
import BoatsKit
import BoatsBot

class TimetableController: NSObject {
    @IBOutlet weak var backgroundGroup: WKInterfaceGroup!
    @IBOutlet weak var dayLabel: WKInterfaceLabel!
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    @IBOutlet weak var hour1Label: WKInterfaceLabel!
    @IBOutlet weak var hour2Label: WKInterfaceLabel!
    @IBOutlet weak var separatorLabel: WKInterfaceLabel!
    @IBOutlet weak var minute1Label: WKInterfaceLabel!
    @IBOutlet weak var minute2Label: WKInterfaceLabel!
    @IBOutlet weak var periodLabel: WKInterfaceLabel!
    @IBOutlet weak var carImage: WKInterfaceImage!
    @IBOutlet weak var deviationGroup: WKInterfaceGroup!
    @IBOutlet weak var deviationLabel: WKInterfaceLabel!
    @IBOutlet weak var strikeGroup: WKInterfaceGroup!
    
    func setHighlighted(_ highlighted: Bool = false) {
        isHighlighted = highlighted
        let color: UIColor = .label(highlighted: isHighlighted)
        backgroundGroup.setBackgroundColor(.foreground(highlighted: isHighlighted))
        dayLabel.setTextColor(color)
        locationLabel.setTextColor(color)
        hour1Label.setTextColor(color)
        hour2Label.setTextColor(color)
        separatorLabel.setTextColor(color)
        minute1Label.setTextColor(color)
        minute2Label.setTextColor(color)
        periodLabel.setTextColor(color)
        deviationLabel.setTextColor(color)
        carImage.setTintColor(color)
        strikeGroup.setBackgroundColor(.black)
    }
    
    func setComplication(_ complication: Complication?, highlighted: Bool = false) {
        dayLabel.setText(complication?.day.abbreviated)
        let components: [String]? = complication?.departure.time.descriptionComponents
        hour1Label.setText(components?[0])
        hour2Label.setText(components?[1])
        separatorLabel.setText(components?[2])
        minute1Label.setText(components?[3])
        minute2Label.setText(components?[4])
        periodLabel.setText(components?[5])
        carImage.setImage(complication?.departure.isCarFerry ?? false ? .car : nil)
        deviationGroup.setHidden(complication?.departure.deviations.isEmpty ?? true)
        deviationLabel.setText(complication?.departure.deviations.first?.description)
        //locationLabel.setText(complication != nil ? "Depart \(complication!.origin.abbreviated) / \(complication!.destination.abbreviated)" : nil)
        
        if let deviation: Deviation = complication?.departure.deviations.first {
            switch deviation {
            case .end:
                strikeGroup.setHidden(!deviation.isExpired)
            default:
                strikeGroup.setHidden(true)
            }
        } else {
            strikeGroup.setHidden(true)
        }
        setHighlighted(highlighted)
    }
    
    private var isHighlighted: Bool = false
}
