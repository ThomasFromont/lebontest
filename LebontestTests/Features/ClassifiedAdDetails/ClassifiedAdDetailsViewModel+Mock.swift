//
//  ClassifiedAdDetailsViewModel+Mock.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

@testable import Lebontest

extension ClassifiedAdDetailsViewModel {
    static func mock(classifiedAd: ClassifiedAd = .mock()) -> ClassifiedAdDetailsViewModel {
        return ClassifiedAdDetailsViewModel(
            classifiedAd: classifiedAd,
            categoryMapperProvider: MockCategoryMapperProvider(),
            dateFormatter: DateFormatter(),
            numberFormatter: NumberFormatter(),
            imageProvider: MockImageProvider()
        )
    }
}
