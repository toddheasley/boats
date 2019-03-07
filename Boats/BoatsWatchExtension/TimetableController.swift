import WatchKit
import BoatsKit

class TimetableController: NSObject {
    func setHighlighted(_ highlighted: Bool = false) {
        isHighlighted = highlighted
        let color: UIColor = .color(highlighted: isHighlighted)
        backgroundGroup.setBackgroundColor(.background(highlighted: isHighlighted))
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
    }
    
    func setDay(_ day: Day? = nil) {
        dayLabel.setText(day?.abbreviated)
        setHighlighted(isHighlighted)
    }
    
    func setDeparture(_ departure: Departure? = nil) {
        let components: [String]? = departure?.time.descriptionComponents
        hour1Label.setText(components?[0])
        hour2Label.setText(components?[1])
        separatorLabel.setText(components?[2])
        minute1Label.setText(components?[3])
        minute2Label.setText(components?[4])
        periodLabel.setText(components?[5])
        carImage.setImage(departure?.isCarFerry ?? false ? .car : nil)
        deviationGroup.setHidden(departure?.deviations.isEmpty ?? true)
        deviationLabel.setText(departure?.deviations.first?.description(relativeTo: Date()))
        setHighlighted(isHighlighted)
    }
    
    func setLocation(_ location: Location? = nil) {
        locationLabel.setText(location != nil ? "Depart \(location!.name.replacingOccurrences(of: " Island", with: ""))" : nil)
        setHighlighted(isHighlighted)
    }
    
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
    
    private var isHighlighted: Bool = false
}
