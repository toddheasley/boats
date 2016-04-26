//
//  XCTestCase.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

extension XCTestCase {
    var mockJSON: AnyObject? {
        guard let resourceName = NSStringFromClass(self.dynamicType).componentsSeparatedByString(".").last, path = NSBundle(forClass: self.dynamicType).pathForResource(resourceName, ofType: ".json"), data = NSData(contentsOfFile: path)else {
            return nil
        }
        return try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
    }
}
