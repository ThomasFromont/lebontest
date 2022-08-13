//
//  XCTestCase+Wait.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 12/08/2022.
//

import XCTest

extension XCTestCase {

    static let defaultTimeout: TimeInterval = 0.1

    func waitForExpectationsWithDefaultTimeout(file: StaticString = #file, line: UInt = #line, handler: XCWaitCompletionHandler? = nil) {
        waitForExpectations(timeout: XCTestCase.defaultTimeout) { error in
            handler?(error)
            if error != nil {
                XCTFail(file: file, line: line)
            }
        }
    }
}
