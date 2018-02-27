import Cocoa

class PanelInputView: InputView {
    
    // MARK: InputView
    override func setUp() {
        super.setUp()
        
        contentView.frame.size.height = 64.0
        
        labelTextField.font = .head
        labelTextField.frame.size.height = 22.0
    }
}
