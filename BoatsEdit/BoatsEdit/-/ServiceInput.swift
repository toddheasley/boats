import Cocoa
import BoatsKit

class ServiceInput: Input {
    private var buttons: [NSButton] = []
    
    var services: [Service] {
        set {
            for (i, service) in Service.all.enumerated() {
                buttons[i].state = newValue.contains(service) ? .on : .off
            }
        }
        get {
            var services: [Service] = []
            for (i, service) in Service.all.enumerated() {
                guard buttons[i].state == .on else {
                    continue
                }
                services.append(service)
            }
            return services
        }
    }
    
    // MARK: Input
    override func setUp() {
        super.setUp()
        
        for (i, service) in Service.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: service.rawValue.capitalized, target: self, action: #selector(inputEdited(_:)))
            button.frame.size.width = 120.0
            button.frame.size.height = 22.0
            button.frame.origin.x = intrinsicContentSize.width - (padding.right + (button.frame.size.width * (i % 2 == 1 ? 1.0 : 2.0)))
            button.frame.origin.y = intrinsicContentSize.height - (padding.top + (button.frame.size.height * CGFloat(i / 2 + 1)))
            addSubview(button)
            buttons.append(button)
        }
        
        label = "Services"
    }
}
