//
//  CategoriesRepository.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

protocol CategoriesRepositoryType {
    func get(onComplete: (([Category]) -> Void)?, onError: ((Error) -> Void)?)
}

class CategoriesRepository: CategoriesRepositoryType {

    // MARK: - Properties

    private let httpClient: HTTPClientType

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    // MARK: - Initializers

    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }

    func get(onComplete: (([Category]) -> Void)?, onError: ((Error) -> Void)?) {
        let endpoint = CategoriesEndpoint.get
        httpClient.request(
            endpoint: endpoint,
            onSuccess: { [weak self] data in
                do {
                    let categories = try self?.decoder.decode([Category].self, from: data) ?? []
                    onComplete?(categories)
                    return
                } catch let error {
                    onError?(error)
                    return
                }
            },
            onError: onError
        )
    }
}
