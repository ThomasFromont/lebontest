//
//  ClassifiedAdsViewModel+Mock.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

@testable import Lebontest

extension ClassifiedAdsViewModel {
    static func mock(
        classifiedAdsRepository: ClassifiedAdsRepositoryType = MockClassifiedAdsRepository()
    ) -> ClassifiedAdsViewModel {
        return ClassifiedAdsViewModel(
            classifiedAdsRepository: classifiedAdsRepository,
            categoryMapperProvider: MockCategoryMapperProvider(),
            numberFormatter: NumberFormatter(),
            imageProvider: MockImageProvider()
        )
    }
}
