//
//  ClassifiedAdsRepositoryTests.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 12/08/2022.
//

import XCTest
@testable import Lebontest

class ClassifiedAdsRepositoryTests: XCTestCase {

    private enum FileName {
        static let categoriesSuccess = "classified-ads-success"
        static let categoriesError = "classified-ads-error"
        static let badRequest = "bad-request"
    }

    private let bundle = Bundle(for: ClassifiedAdsRepositoryTests.self)

    func testGetRequestClassifiedAdsSuccess() {
        let httpClient = MockHTTPClient(fileBundle: bundle, fileName: FileName.categoriesSuccess)
        let repository = ClassifiedAdsRepository(httpClient: httpClient)

        let expectSuccess = expectation(description: "Success should trigger")

        repository.get(
            onComplete: { classifiedAds in
                XCTAssertEqual(classifiedAds.count, 4)
                XCTAssertEqual(classifiedAds[2].id, 1664493117)
                XCTAssertEqual(classifiedAds[2].title, "Professeur natif d'espagnol à domicile")
                expectSuccess.fulfill()
            },
            onError: { error in
                XCTFail("Error should not trigger: \(error)")
            }
        )

        waitForExpectationsWithDefaultTimeout()
    }

    func testGetRequestClassifiedAdsError() {
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
