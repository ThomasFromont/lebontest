//
//  ClassifiedAdDetailsViewModelTests.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import XCTest
@testable import Lebontest

class ClassifiedAdDetailsViewModelTests: XCTestCase {

    func testDelegate() {
        let expectBind = expectation(description: "Bind should trigger")
        let expectClose = expectation(description: "Select close method should trigger")

        let delegate = MockClassifiedAdDetailsViewModelDelegate(
            onSelectClose: { expectClose.fulfill() }
        )

        let viewModel = ClassifiedAdDetailsViewModel.mock()
        viewModel.delegate = delegate

        let bind: ((ClassifiedAdDetailsViewModel.Data) -> Void)? = { data in
            expectBind.fulfill()
        }
        viewModel.bind = bind

        viewModel.fetch()
        wait(for: [expectBind], timeout: XCTestCase.defaultTimeout)

        viewModel.close()
        wait(for: [expectClose], timeout: XCTestCase.defaultTimeout)
    }
}
