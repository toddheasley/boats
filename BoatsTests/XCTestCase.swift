//
//  XCTestCase.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

extension XCTestCase {
    var mockJSON: AnyObject? {
        guard let resourceName = NSStringFromClass(self.dynamicType).components(separatedBy: ".").last, let path = Bundle(for: self.dynamicType).pathForResource(resourceName, ofType: ".json"), let data = try? Foundation.Data(contentsOf: URL(fileURLWithPath: path))else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
    }
}
