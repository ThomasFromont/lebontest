//
//  MockCategoryMapperProvider.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import Foundation
@testable import Lebontest

class MockCategoryMapperProvider: CategoryMapperProviderType {

    // MARK: - Properties

    private let categoryMapper: CategoryMapper

    // MARK: - Initializer

    init(categories: [Lebontest.Category] = []) {
        self.categoryMapper = CategoryMapper(categories: categories)
    }

    // MARK: - CategoryMapperType

    func get(onComplete: ((CategoryMapper) -> Void)?) {
        onComplete?(categoryMapper)
    }
}
