import Cocoa

protocol InputViewDelegate {
    func inputViewDidEdit(_ view: InputView)
    func inputViewDidDelete(_ view: InputView)
}

class InputView: NSView {
    enum Style {
        case label
        case control
        case separator
        case spacer
    }
    
    private let separatorView: NSView = NSView()
    let labelTextField: NSTextField = NSTextField(labelWithString: "")
    let contentView: NSView = NSView()
    
    var input: Any?
    
    private(set) var style: Style = .control
    var delegate: InputViewDelegate?
    
    var label: String? {
        didSet {
            switch style {
            case .label:
                labelTextField.stringValue = label ?? ""
            case .control:
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
            if style == .label,
                let newValue = newValue, !newValue.isEmpty {
                labelTextField.placeholderAttributedString = NSAttributedString(string: "\(newValue)", attributes: [
                    NSAttributedString.Key.font: NSFont.systemFont(ofSize: labelTextField.font!.pointSize, weight: .regular),
                    NSAttributedString.Key.foregroundColor: NSColor.tertiaryLabelColor
                ])
            } else {
                labelTextField.placeholderAttributedString = nil
            }
        }
        get {
            return labelTextField.placeholderAttributedString?.string
        }
    }
    
    var allowsSelection: Bool {
        return style == .label
    }
    
    required init(style: Style = .control) {
        super.init(frame: .zero)
        self.style = style
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        switch style {
        case .label:
            return NSSize(width: .inputWidth, height: 12.0 + padding.height)
        case .control:
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
            labelTextField.textColor = .labelColor
            labelTextField.frame.size.width = intrinsicContentSize.width - padding.width
            labelTextField.frame.size.height = 22.0
            labelTextField.frame.origin.x = padding.left
            labelTextField.frame.origin.y = padding.bottom - 5.0
            addSubview(labelTextField)
        case .control:
            labelTextField.autoresizingMask = [.minYMargin]
            labelTextField.font = .meta
            labelTextField.textColor = .secondaryLabelColor
            labelTextField.frame.size.width = intrinsicContentSize.width - padding.width
            labelTextField.frame.size.height = 17.0
            labelTextField.frame.origin.x = padding.left
            labelTextField.frame.origin.y = bounds.size.height - (padding.top + labelTextField.frame.size.height)
            addSubview(labelTextField)
            
            contentView.frame.size.width = labelTextField.frame.size.width
            contentView.frame.size.height = 8.0
            contentView.frame.origin.x = padding.left
            contentView.frame.origin.y = padding.bottom
            addSubview(contentView)
        case .separator:
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
