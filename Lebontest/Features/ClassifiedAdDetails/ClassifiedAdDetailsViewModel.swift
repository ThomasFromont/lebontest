//
//  ClassifiedAdDetailsViewModel.swift
//  Lebontest
//
//  Created by Thomas Fromont on 13/08/2022.
//

import UIKit

protocol ClassifiedAdDetailsViewModelDelegate: AnyObject {
    func didSelectClose(from: ClassifiedAdDetailsViewModel)
}

final class ClassifiedAdDetailsViewModel {

    struct Data {
        let image: UIImage?
    }

    // MARK: - Properties

    weak var delegate: ClassifiedAdDetailsViewModelDelegate?

    private let classifiedAd: ClassifiedAd
    private let categoryMapperProvider: CategoryMapperProviderType
    private let numberFormatter: NumberFormatterType
    private let imageProvider: ImageProviderType

    // MARK: - Inputs

    func fetch() {
        imageProvider.getImage(from: classifiedAd.imagesUrl.thumb) { [weak self] image in
            self?.bind?(Data(image: image))
        }
    }

    func close() {
        delegate?.didSelectClose(from: self)
    }

    // MARK: - Outputs

    let navigationTitle: String
    var bind: ((Data) -> Void)?

    // MARK: - Initializers

    init(
        classifiedAd: ClassifiedAd,
        categoryMapperProvider: CategoryMapperProviderType,
        numberFormatter: NumberFormatterType,
        imageProvider: ImageProviderType
    ) {
        self.classifiedAd = classifiedAd
        self.categoryMapperProvider = categoryMapperProvider
        self.numberFormatter = numberFormatter
        self.imageProvider = imageProvider

        navigationTitle = Translation.ClassifiedAdDetails.navigationTitle
    }
}
