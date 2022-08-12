//
//  CategoryEndpoint.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

enum CategoriesEndpoint: Endpoint {

    case get

    private enum Path {
        static let base = "categories.json"
    }

    // MARK: Endpoint

    var path: String {
        switch self {
        case .get:
            return Path.base
        }
    }
}
