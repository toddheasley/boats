import Cocoa

protocol InputViewDelegate {
    func inputViewDidEdit(_ view: InputView)
    func inputViewDidDelete(_ view: InputView)
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
    var input: Any?
    
    var label: String? {
        didSet {
            switch style {
            case .label:
                labelTextField.stringValue = label ?? ""
            case .custom:
                labelTextField.stringValue = label?.uppercased() ?? ""
            default:
                labelTextField.stringValue = ""
                if let _: String = label {
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
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        switch style {
        case .label:
            return NSSize(width: .inputWidth, height: 12.0 + padding.height)
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
    
    override func setUp() {
        super.setUp()
        
        switch style {
        case .label:
            labelTextField.font = .base(.bold)
            labelTextField.frame.size.width = intrinsicContentSize.width - padding.width
            labelTextField.frame.size.height = 22.0
            labelTextField.frame.origin.x = padding.left
            labelTextField.frame.origin.y = padding.bottom - 5.0
            addSubview(labelTextField)
        case .custom:
            contentView.frame.size.width = intrinsicContentSize.width - padding.width
            contentView.frame.size.height = 8.0
            contentView.frame.origin.x = padding.left
            contentView.frame.origin.y = padding.bottom
            addSubview(contentView)
            
            labelTextField.autoresizingMask = [.minYMargin]
            labelTextField.font = .meta
            labelTextField.frame.size.width = contentView.bounds.size.width
            labelTextField.frame.size.height = 14.0
            labelTextField.frame.origin.x = padding.left
            labelTextField.frame.origin.y = bounds.size.height - (padding.top + labelTextField.frame.size.height)
            addSubview(labelTextField)
        case .separator:
            separatorView.wantsLayer = true
            separatorView.layer?.backgroundColor = NSColor.separator.cgColor
            separatorView.frame.size.width = intrinsicContentSize.width - padding.width
            separatorView.frame.size.height = 0.5
            separatorView.frame.origin.x = padding.left
            separatorView.frame.origin.y = padding.bottom
            addSubview(separatorView)
        case .spacer:
            break
        }
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Array {
    @discardableResult mutating func move(from i: Int, to ii: Int) -> Bool {
        let range: ClosedRange<Int> = 0...(count - 1)
        guard range.contains(i), range.contains(ii) else {
            return false
        }
        var elements = self
        let element = elements[i]
        elements.remove(at: i)
        elements.insert(element, at: i < ii ? ii - 1: ii)
        self = elements
        return true
    }
}

extension CGFloat {
    static let inputWidth: CGFloat = 360.0
}
