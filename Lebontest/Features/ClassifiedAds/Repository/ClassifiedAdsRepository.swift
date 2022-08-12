//
//  ClassifiedAdsRepository.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

protocol ClassifiedAdsRepositoryType {
    func get(onComplete: (([ClassifiedAd]) -> Void)?, onError: ((Error) -> Void)?)
}

class ClassifiedAdsRepository: ClassifiedAdsRepositoryType {

    // MARK: - Properties

    private let httpClient: HTTPClientType

    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    // MARK: - Initializers

    init(httpClient: HTTPClientType) {
        self.httpClient = httpClient
    }

    func get(onComplete: (([ClassifiedAd]) -> Void)?, onError: ((Error) -> Void)?) {
        let endpoint = ClassifiedAdsEndpoint.get
        httpClient.request(
            endpoint: endpoint,
            onSuccess: { [weak self] data in
                do {
                    let classifiedAds = try self?.decoder.decode([ClassifiedAd].self, from: data) ?? []
                    onComplete?(classifiedAds)
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
