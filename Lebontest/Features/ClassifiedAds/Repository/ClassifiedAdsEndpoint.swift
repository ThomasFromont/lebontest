//
//  ClassifiedAdsEndpoint.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

enum ClassifiedAdsEndpoint: Endpoint {

    case get

    private enum Path {
        static let base = "listing.json"
    }

    // MARK: Endpoint

    var path: String {
        switch self {
        case .get:
            return Path.base
        }
    }
}
