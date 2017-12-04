//
// © 2018 @toddheasley
//

import Cocoa

protocol InputDelegate {
    func inputDidEdit(_ input: Input)
}

class Input: NSView {
    let contentInsets: NSEdgeInsets = NSEdgeInsets(top: 4.0, left: 14.0, bottom: 8.0, right: 14.0)
    let labelTextField: NSTextField = NSTextField(labelWithString: "")
    
    private(set) var allowsSelection: Bool = false
    var delegate: InputDelegate?
    
    var label: String {
        set {
            labelTextField.stringValue = newValue
        }
        get {
            return labelTextField.stringValue
        }
    }
    
    var u: Int {
        return 1
    }
    
    @IBAction func inputEdited(_ sender: AnyObject?) {
        delegate?.inputDidEdit(self)
    }
    
    func setUp() {
        labelTextField.font = .systemFont(ofSize: 11.0)
        labelTextField.textColor = .disabledControlTextColor
        labelTextField.frame.size.width = intrinsicContentSize.width - contentInsets.width
        labelTextField.frame.size.height = 17.0
        labelTextField.frame.origin.x = contentInsets.left
        labelTextField.frame.origin.y = intrinsicContentSize.height - (labelTextField.frame.size.height + contentInsets.top + 4.0)
        addSubview(labelTextField)
    }
    
    // MARK: NSView
    override var intrinsicContentSize: NSSize {
        return NSSize(width: 360.0, height: (22.0 * CGFloat(u)) + contentInsets.height)
    }
    
    override var frame: NSRect {
        set {
            super.frame.size = intrinsicContentSize
            super.frame.origin = newValue.origin
        }
        get {
            return super.frame
        }
    }
    
    override init(frame rect: NSRect) {
        super.init(frame: rect)
        frame = rect
        setUp()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        setUp()
    }
}

extension Array where Element: Input {
    @discardableResult mutating func move(from index: Int, to newIndex: Int) -> Bool {
        let range: ClosedRange<Int> = 0...(count - 1)
        guard range.contains(index), range.contains(newIndex) else {
            return false
        }
        let input = self[index]
        remove(at: index)
        insert(input, at: index < newIndex ? newIndex - 1: newIndex)
        return true
    }
}
