//
//  MockClassifiedAdsRepository.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import Foundation
@testable import Lebontest

class MockClassifiedAdsRepository: ClassifiedAdsRepositoryType {

    private let classifiedAds: [ClassifiedAd]

    init(classifiedAds: [ClassifiedAd] = [.mock()]) {
        self.classifiedAds = classifiedAds
    }

    func get(onComplete: (([ClassifiedAd]) -> Void)?, onError: ((Error) -> Void)?) {
        onComplete?(classifiedAds)
    }
}
