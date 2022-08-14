//
//  CategoryMapperProvider.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

protocol CategoryMapperProviderType: AnyObject {
    func get(onComplete: ((CategoryMapper) -> Void)?)
}

class CategoryMapperProvider: CategoryMapperProviderType {

    // MARK: - Properties

    private var categoryMapper = CategoryMapper(categories: [])
    private let categoriesRepository: CategoriesRepositoryType
    private let dispatchGroup = DispatchGroup()

    // MARK: - Initializer

    init(categoriesRepository: CategoriesRepositoryType) {
        self.categoriesRepository = categoriesRepository

        dispatchGroup.enter()
        categoriesRepository.get(
            onComplete: { [weak self] categories in
                self?.categoryMapper = CategoryMapper(categories: categories)
                self?.dispatchGroup.leave()
            },
            onError: { [weak self] _ in
                self?.dispatchGroup.leave()
            }
        )
    }

    // MARK: - CategoryMapperType

    func get(onComplete: ((CategoryMapper) -> Void)?) {
        dispatchGroup.notify(queue: .main) {
            onComplete?(self.categoryMapper)
        }
    }
}
