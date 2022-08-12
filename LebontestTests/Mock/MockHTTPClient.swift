//
//  MockHTTPClient.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 12/08/2022.
//

import Foundation
@testable import Lebontest

enum MockAPIError: Error {
    case error
}

class MockHTTPClient: HTTPClientType {

    // MARK: - Properties

    private let data: Data?

    // MARK: - Initializers

    init(data: Data?) {
        self.data = data
    }

    convenience init(fileBundle: Bundle, fileName: String) {
        guard let path = fileBundle.path(forResource: fileName, ofType: "json") else {
            self.init(data: nil)
            assertionFailure("File not found")
            return
        }
        let data = FileManager.default.contents(atPath: path)
        self.init(data: data)
    }

    // MARK: - HTTPClientType

    func request(endpoint: Endpoint, onSuccess: ((Data) -> Void)?, onError: ((Error) -> Void)?) {
        guard let data = data else {
            onError?(MockAPIError.error)
            return
        }
        onSuccess?(data)
    }
}
