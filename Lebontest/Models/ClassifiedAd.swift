//
//  ClassifiedAd.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import Foundation

struct ClassifiedAd: Decodable {
    let id: Int
    let title: String
    let categoryId: Int
    var categoryName: String?
    let creationDate: Date
    let description: String
    let imagesUrl: ImagesURL
    let isUrgent: Bool
    let price: Double
    let siret: String?

    struct ImagesURL: Decodable {
        let small: String?
        let thumb: String?
    }
}
