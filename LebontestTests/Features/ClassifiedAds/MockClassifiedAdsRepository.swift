//
//  MockClassifiedAdsRepository.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import Foundation
@testable import Lebontest

class MockClassifiedAdsRepository: ClassifiedAdsRepositoryType {

    enum Response {
        case complete([ClassifiedAd])
        case error(Error)
    }

    private let response: Response

    init(response: Response = .complete([.mock()])) {
        self.response = response
    }

    func get(onComplete: (([ClassifiedAd]) -> Void)?, onError: ((Error) -> Void)?) {
        switch response {
        case .complete(let classifiedAds):
            onComplete?(classifiedAds)
        case .error(let error):
            onError?(error)
        }
    }
}
