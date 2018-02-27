import Cocoa

protocol InputViewDelegate {
    func inputViewDidEdit(_ view: InputView)
}

class InputView: NSView {
    enum Style {
        case label
        case custom
        case separator
        case spacer
    }
    
    private let separatorView: NSView = NSView()
    let labelTextField: NSTextField = NSTextField(labelWithString: "")
    let contentView: NSView = NSView()
    
    private(set) var style: Style = .custom
    var delegate: InputViewDelegate?
    
    var label: String? {
        didSet {
            switch style {
            case .label:
                labelTextField.stringValue = label?.uppercased() ?? ""
            case .custom:
                labelTextField.stringValue = label ?? ""
            default:
                labelTextField.stringValue = ""
                if let _ = label {
                    label = nil
                }
            }
        }
    }
    
    var placeholder: String? {
        set {
            labelTextField.placeholderString = style == .label ? newValue : nil
        }
        get {
            return labelTextField.placeholderString
        }
    }
    
    var allowsSelection: Bool {
        return style == .label
    }
    
    required init(style: Style) {
        super.init(frame: .zero)
        self.style = className == InputView().className ? style : .custom
        setUp()
    }
    
    @IBAction func inputEdited(_ sender: AnyObject?) {
        delegate?.inputViewDidEdit(self)
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        switch style {
        case .label:
            return NSSize(width: .inputWidth, height: labelTextField.bounds.size.height + padding.height)
        case .custom:
            return NSSize(width: .inputWidth, height: contentView.bounds.size.height + padding.height)
        case .spacer, .separator:
            return NSSize(width: .inputWidth, height: padding.height)
        }
    }
    
    override var frame: NSRect {
        set {
            super.frame = NSRect(origin: newValue.origin, size: intrinsicContentSize)
        }
        get {
            return super.frame
        }
    }
    
    override func layout() {
        super.layout()
        
        labelTextField.frame.origin.y = contentView.bounds.size.height - labelTextField.frame.size.height
    }
    
    override func setUp() {
        super.setUp()
        
        switch style {
        case .label:
            labelTextField.font = .base(.bold)
            labelTextField.frame.size.width = intrinsicContentSize.width - padding.width
            labelTextField.frame.size.height = 22.0
            labelTextField.frame.origin.x = padding.left
            labelTextField.frame.origin.y = padding.bottom
            addSubview(labelTextField)
        case .custom:
            contentView.frame.size.width = intrinsicContentSize.width - padding.width
            contentView.frame.size.height = 12.0
            contentView.frame.origin.x = padding.left
            contentView.frame.origin.y = padding.bottom
            addSubview(contentView)
            
            labelTextField.font = .meta
            labelTextField.frame = contentView.bounds
            labelTextField.frame.origin.y = contentView.bounds.size.height - labelTextField.frame.size.height
            contentView.addSubview(labelTextField)
        case .separator:
            separatorView.wantsLayer = true
            separatorView.layer?.backgroundColor = NSColor.separator.cgColor
            separatorView.frame.size.width = intrinsicContentSize.width - padding.width
            separatorView.frame.size.height = 1.0
            separatorView.frame.origin.x = padding.left
            separatorView.frame.origin.y = padding.bottom
            addSubview(separatorView)
        case .spacer:
            break
        }
        

        wantsLayer = true
        layer?.backgroundColor = NSColor.red.withAlphaComponent(0.15).cgColor
        
        labelTextField.wantsLayer = true
        labelTextField.layer?.backgroundColor = layer?.backgroundColor
        
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = layer?.backgroundColor
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Array where Element: InputView {
    @discardableResult mutating func move(from i: Int, to ii: Int) -> Bool {
        let range: ClosedRange<Int> = 0...(count - 1)
        guard range.contains(i), range.contains(ii) else {
            return false
        }
        let input = self[i]
        remove(at: i)
        insert(input, at: i < ii ? ii - 1: i)
        return true
    }
}

extension CGFloat {
    static let inputWidth: CGFloat = 360.0
}
