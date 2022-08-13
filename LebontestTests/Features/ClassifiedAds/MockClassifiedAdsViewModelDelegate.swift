//
//  MockClassifiedAdsViewModelDelegate.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

@testable import Lebontest

class MockClassifiedAdsViewModelDelegate: ClassifiedAdsViewModelDelegate {

    private let onSelect: ((ClassifiedAd) -> Void)?

    init(onSelect: ((ClassifiedAd) -> Void)? = nil) {
        self.onSelect = onSelect
    }

    func didSelect(classifiedAd: ClassifiedAd, from: ClassifiedAdsViewModel) {
        onSelect?(classifiedAd)
    }
}
