//
//  Asset.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

// MARK: - Asset

internal enum Asset {
    static let logo = ImageAsset(name: "logo")
    static let iconClose = ImageAsset(name: "icon_close")
}

// MARK: - Implementation Details

internal struct ImageAsset {
    internal fileprivate(set) var name: String

    internal var image: UIImage {
        let bundle = BundleToken.bundle
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    internal func image(compatibleWith traitCollection: UITraitCollection) -> UIImage {
        let bundle = BundleToken.bundle
        guard let result = UIImage(named: name, in: bundle, compatibleWith: traitCollection) else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

private final class BundleToken {
    static let bundle: Bundle = {
        return Bundle(for: BundleToken.self)
    }()
}
