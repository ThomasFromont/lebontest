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

    // MARK: - Nested

    typealias Info = (title: String?, subtitle: String)

    struct Data {
        let image: UIImage?
    }

    // MARK: - Properties

    weak var delegate: ClassifiedAdDetailsViewModelDelegate?

    private let classifiedAd: ClassifiedAd
    private let categoryMapperProvider: CategoryMapperProviderType
    private let dateFormatter: DateFormatterType
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
    let title: String
    let price: String
    let date: String
    let category: String?
    let tag: String?
    let description: Info
    let siret: Info?

    var bind: ((Data) -> Void)?

    // MARK: - Initializers

    init(
        classifiedAd: ClassifiedAd,
        categoryMapperProvider: CategoryMapperProviderType,
        dateFormatter: DateFormatterType,
        numberFormatter: NumberFormatterType,
        imageProvider: ImageProviderType
    ) {
        self.classifiedAd = classifiedAd
        self.categoryMapperProvider = categoryMapperProvider
        self.dateFormatter = dateFormatter
        self.numberFormatter = numberFormatter
        self.imageProvider = imageProvider

        navigationTitle = Translation.ClassifiedAdDetails.navigationTitle
        title = classifiedAd.title
        price = numberFormatter.format(value: classifiedAd.price, minDigits: 0, maxDigits: 2) + " €"
        date = dateFormatter.formatDayRelative(date: classifiedAd.creationDate, relativeTo: Date())
        category = classifiedAd.categoryName
        tag = classifiedAd.isUrgent ? Translation.ClassifiedAdDetails.urgent : nil
        description = (title: Translation.ClassifiedAdDetails.description, subtitle: classifiedAd.description)
        siret = classifiedAd.siret.map { (title: nil, subtitle: Translation.ClassifiedAdDetails.siret($0)) }
    }
}
