//
//  BoatsEdit
//  © 2017 @toddheasley
//

import Cocoa
import BoatsKit
import BoatsWeb

class ViewController: NSViewController {
    @IBAction func write(_ sender: AnyObject?) {
        let url: URL = URL(fileURLWithPath: "/Users/toddheasley/Desktop/Test/index.json", isDirectory: true)
        
        do {
            try Data().write(to: url)
        } catch let error {
            print(error)
        }
        
        /*
        Index.read(from: url) { index, error in
            guard let index = index else {
                print(error)
                return
            }
            print(index)
        }
         */
        
        print(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var representedObject: Any? {
        didSet {
            
        }
    }
}
