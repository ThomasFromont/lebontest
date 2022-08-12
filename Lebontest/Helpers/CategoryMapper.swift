//
//  CategoryMapper.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

import Foundation

protocol CategoryMapperType: AnyObject {
    func getCategoryName(id: Int) -> Category?
}

class CategoryMapper: CategoryMapperType {

    // MARK: - Properties

    private var categories = [Category]()
    private let dispatchGroup = DispatchGroup()

    // MARK: - Initializer

    init(categories: [Category]) {
        self.categories = categories
    }

    // MARK: - CategoryMapperType

    func getCategoryName(id: Int) -> Category? {
        return categories.first(where: { $0.id == id })
    }
}
