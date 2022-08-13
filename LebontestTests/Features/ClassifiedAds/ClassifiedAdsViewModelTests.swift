//
//  ClassifiedAdsViewModelTests.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import XCTest
@testable import Lebontest

class ClassifiedAdsViewModelTests: XCTestCase {

    func testDelegate() {
        let classifiedAd = ClassifiedAd.mock()

        let expectBind = expectation(description: "Bind should trigger")
        let expectClassifiedAd = expectation(description: "Select classified ad delegate method should trigger")

        let delegate = MockClassifiedAdsViewModelDelegate(
            onSelect: { someClassifiedAd in
                XCTAssertEqual(someClassifiedAd.id, classifiedAd.id)
                expectClassifiedAd.fulfill()
            }
        )

        let viewModel = ClassifiedAdsViewModel.mock(
            classifiedAdsRepository: MockClassifiedAdsRepository(classifiedAds: [classifiedAd])
        )
        viewModel.delegate = delegate

        var adCellViewModel: AdCellViewModel?
        let bind: ((ClassifiedAdsViewModel.Data) -> Void)? = { data in
            expectBind.fulfill()
            adCellViewModel = data.cellViewModels.first
        }
        viewModel.bind = bind

        viewModel.fetch()
        wait(for: [expectBind], timeout: XCTestCase.defaultTimeout)

        guard adCellViewModel != nil else {
            return XCTFail("Wrong cell type")
        }

        adCellViewModel?.select()
        wait(for: [expectClassifiedAd], timeout: XCTestCase.defaultTimeout)
    }

    func testClassifiedAdCell() {
        let title = "🐼"
        let classifiedAd = ClassifiedAd.mock(title: title)
        let cells = recordedCellViewModels(classifiedAds: [classifiedAd])

        guard cells.count == 1 else {
            return XCTFail("Wrong cell type")
        }

        XCTAssertEqual(cells[0].title, title)
    }

    private func recordedCellViewModels(classifiedAds: [ClassifiedAd] = [.mock()]) -> [AdCellViewModel] {
        let expectation = self.expectation(description: "cells")

        let classifiedAdsRepository = MockClassifiedAdsRepository(classifiedAds: classifiedAds)
        let viewModel = ClassifiedAdsViewModel.mock(classifiedAdsRepository: classifiedAdsRepository)

        var recordedCellViewModels: [AdCellViewModel] = []

        let bind: ((ClassifiedAdsViewModel.Data) -> Void)? = { data in
            expectation.fulfill()
            recordedCellViewModels = data.cellViewModels
        }
        viewModel.bind = bind

        viewModel.fetch()
        waitForExpectationsWithDefaultTimeout()

        return recordedCellViewModels
    }
}
