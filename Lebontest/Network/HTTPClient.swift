//
//  HTTPClient.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation

enum APIError: Error {
    case malformedURL
    case unexpectedStatusCode
    case dataEmpty
}

protocol HTTPClientType {
    func request(endpoint: Endpoint, onSuccess: ((Data) -> Void)?, onError: ((Error) -> Void)?)
}

final class HTTPClient: HTTPClientType {

    private enum Constant {
        static let url = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    }

    func request(endpoint: Endpoint, onSuccess: ((Data) -> Void)?, onError: ((Error) -> Void)?) {
        let urlString = Constant.url + endpoint.path

        guard let url = URL(string: urlString) else {
            onError?(APIError.malformedURL)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                onError?(error)
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                onError?(APIError.unexpectedStatusCode)
                return
            }

            guard let data = data else {
                onError?(APIError.dataEmpty)
                return
            }

            onSuccess?(data)
        }
        task.resume()
    }
}
