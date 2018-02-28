import Cocoa

class PanelInputView: InputView {
    enum Accessory {
        case web
        case delete
        case none
    }
    
    private let webButton: NSButton = NSButton(checkboxWithTitle: "Include Web Pages", target: nil, action: nil)
    private let deleteButton: NSButton = NSButton()
    
    var accessory: Accessory = .none {
        didSet {
            layout()
        }
    }
    
    var web: Bool {
        set {
            webButton.state = newValue ? .on : .off
        }
        get {
            return webButton.state == .on
        }
    }
    
    @objc func handleWeb(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    @objc func handleDelete(_ sender: AnyObject?) {
        delegate?.inputViewDidDelete(self)
    }
    
    convenience init(accessory: Accessory) {
        self.init(frame: .zero)
        self.accessory = accessory
    }
    
    // MARK: InputView
    override var label: String? {
        didSet {
            labelTextField.stringValue = label ?? ""
        }
    }
    
    override func layout() {
        super.layout()
        
        webButton.isHidden = true
        deleteButton.isHidden = true
        switch accessory {
        case .web:
            labelTextField.frame.size.width = webButton.frame.origin.x - (padding.width / 2.0)
            webButton.isHidden = false
        case .delete:
            labelTextField.frame.size.width = deleteButton.frame.origin.x - (padding.width / 2.0)
            deleteButton.isHidden = false
        case .none:
            labelTextField.frame.size.width = contentView.frame.size.width
        }
    }
    
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = 64.0
        
        labelTextField.font = .head
        labelTextField.frame.size.height = 22.0
        labelTextField.frame.origin.y = bounds.size.height - (padding.top + labelTextField.frame.size.height)
        
        webButton.frame.size.height = labelTextField.frame.size.height
        webButton.frame.origin.x = contentView.bounds.size.width - webButton.frame.size.width
        webButton.frame.origin.y = contentView.bounds.size.height - webButton.frame.size.height
        webButton.target = self
        webButton.action = #selector(handleWeb(_:))
        contentView.addSubview(webButton)
        
        deleteButton.image = NSImage(named: .touchBarDeleteTemplate)
        deleteButton.setButtonType(.momentaryChange)
        deleteButton.isBordered = false
        deleteButton.frame.size.width = labelTextField.frame.size.height
        deleteButton.frame.size.height = labelTextField.frame.size.height
        deleteButton.frame.origin.x = contentView.bounds.size.width - deleteButton.frame.size.width
        deleteButton.frame.origin.y = contentView.bounds.size.height - deleteButton.frame.size.height
        deleteButton.target = self
        deleteButton.action = #selector(handleDelete(_:))
        contentView.addSubview(deleteButton)
    }
}
