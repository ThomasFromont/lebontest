//
//  AdCellViewModel.swift
//  Lebontest
//
//  Created by Thomas Fromont on 12/08/2022.
//

import UIKit

final class AdCellViewModel {

    struct Data {
        let image: UIImage
    }

    // MARK: - Inputs

    func fetch() {
        imageProvider.getImage(from: classifiedAd.imagesUrl.small) { [weak self] image in
            guard let image = image else {
                return
            }
            self?.bind?(Data(image: image))
        }
    }

    // MARK: - Outputs

    let title: String
    let subtitle: String
    let info: String?
    let tag: String?

    var bind: ((Data) -> Void)?

    // MARK: - Properties

    private let classifiedAd: ClassifiedAd
    private let imageProvider: ImageProviderType
    private let onSelect: (() -> Void)?

    // MARK: - Initializers

    init(
        classifiedAd: ClassifiedAd,
        category: Category?,
        numberFormatter: NumberFormatterType,
        imageProvider: ImageProviderType,
        onSelect: (() -> Void)? = nil
    ) {
        self.classifiedAd = classifiedAd
        self.title = classifiedAd.title
        self.subtitle = numberFormatter.format(value: classifiedAd.price, minDigits: 0, maxDigits: 2) + " €"
        self.info = category?.name
        self.tag = classifiedAd.isUrgent ? Translation.ClassifiedAds.Cell.urgent : nil
        self.imageProvider = imageProvider
        self.onSelect = onSelect
    }

    func select() {
        onSelect?()
    }
}
