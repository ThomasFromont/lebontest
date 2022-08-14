//
//  CategoriesRepositoryTests.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 12/08/2022.
//

import XCTest
@testable import Lebontest

class CategoriesRepositoryTests: XCTestCase {

    private enum FileName {
        static let categoriesSuccess = "categories-success"
        static let categoriesError = "categories-error"
        static let badRequest = "bad-request"
    }

    private let bundle = Bundle(for: CategoriesRepositoryTests.self)

    func testGetRequestCategoriesSuccess() {
        let httpClient = MockHTTPClient(fileBundle: bundle, fileName: FileName.categoriesSuccess)
        let repository = CategoriesRepository(httpClient: httpClient)

        let expectSuccess = expectation(description: "Success should trigger")

        repository.get(
            onComplete: { categories in
                XCTAssertEqual(categories.count, 11)
                XCTAssertEqual(categories[9].id, 10)
                XCTAssertEqual(categories[9].name, "Animaux")
                expectSuccess.fulfill()
            },
            onError: { error in
                XCTFail("Error should not trigger: \(error)")
            }
        )

        waitForExpectationsWithDefaultTimeout()
    }

    func testGetRequestCategoriesError() {
        let httpClient = MockHTTPClient(fileBundle: bundle, fileName: FileName.categoriesError)
        let repository = CategoriesRepository(httpClient: httpClient)

        let expectError = expectation(description: "Error should trigger")

        repository.get(
            onComplete: { categories in
                XCTFail("Success should not trigger: \(categories)")
            },
            onError: { error in
                expectError.fulfill()
            }
        )

        waitForExpectationsWithDefaultTimeout()
    }

    func testGetRequestBadRequest() {
        let httpClient = MockHTTPClient(fileBundle: bundle, fileName: FileName.categoriesError)
        let repository = CategoriesRepository(httpClient: httpClient)

        let expectError = expectation(description: "Error should trigger")

        repository.get(
            onComplete: { categories in
                XCTFail("Success should not trigger: \(categories)")
            },
            onError: { error in
                expectError.fulfill()
            }
        )

        waitForExpectationsWithDefaultTimeout()
    }
}
