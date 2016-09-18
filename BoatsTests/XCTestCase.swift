//
//  XCTestCase.swift
//  Boats
//
//  (c) 2016 @toddheasley
//

import XCTest

extension XCTestCase {
    var mockJSON: Any? {
        guard let resourceName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last, let path = Bundle(for: type(of: self)).path(forResource: resourceName, ofType: ".json"), let data = try? Foundation.Data(contentsOf: URL(fileURLWithPath: path))else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
    }
}
