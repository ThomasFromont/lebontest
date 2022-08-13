//
//  ClassifiedAd+Mock.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import Foundation
@testable import Lebontest

extension ClassifiedAd {
    static func mock(
        id: Int = 123456789,
        title: String = "Title",
        categoryId: Int = 1,
        creationDate: Date = Date(),
        description: String = "Description",
        imagesUrl: ImagesURL = .init(small: "small", thumb: "thumb"),
        isUrgent: Bool =  false,
        price: Double = 42.0,
        siret: String? = nil
    ) -> ClassifiedAd {
        return ClassifiedAd(
            id: id,
            title: title,
            categoryId: categoryId,
            creationDate: creationDate,
            description: description,
            imagesUrl: imagesUrl,
            isUrgent: isUrgent,
            price: price,
            siret: siret
        )
    }
}
