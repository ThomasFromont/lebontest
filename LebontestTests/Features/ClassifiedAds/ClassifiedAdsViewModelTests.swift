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
        expectBind.expectedFulfillmentCount = 2
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

        var recordedStates = [ClassifiedAdsViewModel.State]()
        let bind: ((ClassifiedAdsViewModel.State) -> Void)? = { state in
            expectBind.fulfill()
            recordedStates.append(state)
        }
        viewModel.bind = bind

        viewModel.fetch()
        wait(for: [expectBind], timeout: XCTestCase.defaultTimeout)

        guard
            recordedStates.count == 2,
            case .loading = recordedStates[0],
            case .success(let adCellViewModels) = recordedStates[1]
        else {
            return XCTFail("Wrong states")
        }

        guard adCellViewModels.count == 1 else {
            return XCTFail("Wrong cells count")
        }

        adCellViewModels[0].select()
        wait(for: [expectClassifiedAd], timeout: XCTestCase.defaultTimeout)
    }

    func testClassifiedAdCell() {
        let title = "🐼"
        let classifiedAd = ClassifiedAd.mock(title: title)
        let states = recordedStates(classifiedAds: [classifiedAd])

        guard
            states.count == 2,
            case .loading = states[0],
            case .success(let adCellViewModels) = states[1]
        else {
            return XCTFail("Wrong states")
        }

        guard adCellViewModels.count == 1 else {
            return XCTFail("Wrong cell type")
        }

        XCTAssertEqual(adCellViewModels[0].title, title)
    }

    private func recordedStates(classifiedAds: [ClassifiedAd] = [.mock()]) -> [ClassifiedAdsViewModel.State] {
        let expectation = self.expectation(description: "bind")
        expectation.expectedFulfillmentCount = 2

        let classifiedAdsRepository = MockClassifiedAdsRepository(classifiedAds: classifiedAds)
        let viewModel = ClassifiedAdsViewModel.mock(classifiedAdsRepository: classifiedAdsRepository)

        var recordedStates = [ClassifiedAdsViewModel.State]()
        let bind: ((ClassifiedAdsViewModel.State) -> Void)? = { state in
            expectation.fulfill()
            recordedStates.append(state)
        }
        viewModel.bind = bind

        viewModel.fetch()
        wait(for: [expectation], timeout: XCTestCase.defaultTimeout)

        return recordedStates
    }
}
