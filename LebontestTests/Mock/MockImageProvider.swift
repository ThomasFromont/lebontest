//
//  MockImageProvider.swift
//  LebontestTests
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit
@testable import Lebontest

class MockImageProvider: ImageProviderType {
    func getImage(from url: String?, completion: ((UIImage?) -> Void)?) {
        completion?(UIImage())
    }
}
