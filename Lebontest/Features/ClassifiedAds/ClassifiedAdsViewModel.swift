//
//  ClassifiedAdsViewModel.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

protocol ClassifiedAdsViewModelDelegate: AnyObject {
    func didSelect(classifiedAd: ClassifiedAd, from: ClassifiedAdsViewModel)
}

final class ClassifiedAdsViewModel {

    struct Data {
        public let cells: [AdCellViewModel]
    }

    // MARK: - Properties

    weak var delegate: ClassifiedAdsViewModelDelegate?

    // MARK: - Inputs

    func fetch() {
        bind?(Data(cells: [AdCellViewModel(), AdCellViewModel(), AdCellViewModel()]))
    }

    // MARK: - Outputs

    let navigationTitle: String
    var bind: ((Data) -> Void)?

    // MARK: - Initializers

    init() {
        navigationTitle = Translation.ClassifiedAds.navigationTitle
    }

    // MARK: - Private

    private func selectClassifiedAd(_ classifiedAd: ClassifiedAd) {
        delegate?.didSelect(classifiedAd: classifiedAd, from: self)
    }
}
