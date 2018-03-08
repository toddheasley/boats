import Cocoa
import BoatsKit

class ServiceInputView: InputView {
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
    
    @objc func handleService(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = (ceil(CGFloat(Service.all.count) / 2.0) * 22.0) - 3.0
        for (i, service) in Service.all.enumerated() {
            let button: NSButton = NSButton(checkboxWithTitle: service.rawValue.capitalized, target: self, action: #selector(handleService(_:)))
            button.frame.size.width = 120.0
            button.frame.size.height = 22.0
            button.frame.origin.x = contentView.bounds.size.width - (button.frame.size.width * (i % 2 == 1 ? 1.0 : 2.0))
            button.frame.origin.y = contentView.bounds.size.height - (button.frame.size.height * CGFloat(i / 2 + 1)) + 3.0
            
            contentView.addSubview(button)
            buttons.append(button)
        }
        
        label = "Services"
    }
}
