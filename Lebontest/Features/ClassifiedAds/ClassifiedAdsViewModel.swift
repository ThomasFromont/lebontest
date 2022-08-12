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
        let cellViewModels: [AdCellViewModel]
    }

    // MARK: - Properties

    private let classifiedAdsRepository: ClassifiedAdsRepositoryType
    private let categoryMapperProvider: CategoryMapperProviderType

    weak var delegate: ClassifiedAdsViewModelDelegate?

    // MARK: - Inputs

    func fetch() {
        // TODO: - Handle loading
        classifiedAdsRepository.get(
            onComplete: { [weak self] classifiedAds in
                self?.categoryMapperProvider.get { [weak self] categoryMapper in
                    let cellViewModels = self?.buildCellViewModels(
                        classifiedAds: classifiedAds,
                        categoryMapper: categoryMapper
                    ) ?? []
                    self?.bind?(Data(cellViewModels: cellViewModels))
                }
            },
            onError: { error in
                // TODO: - Handle error
            }
        )
    }

    // MARK: - Outputs

    let navigationTitle: String
    var bind: ((Data) -> Void)?

    // MARK: - Initializers

    init(
        classifiedAdsRepository: ClassifiedAdsRepositoryType,
        categoryMapperProvider: CategoryMapperProviderType
    ) {
        self.classifiedAdsRepository = classifiedAdsRepository
        self.categoryMapperProvider = categoryMapperProvider
        navigationTitle = Translation.ClassifiedAds.navigationTitle
    }

    // MARK: - Private

    private func selectClassifiedAd(_ classifiedAd: ClassifiedAd) {
        delegate?.didSelect(classifiedAd: classifiedAd, from: self)
    }

    private func buildCellViewModels(classifiedAds: [ClassifiedAd], categoryMapper: CategoryMapper) -> [AdCellViewModel] {
        classifiedAds.map { _ in
            AdCellViewModel()
        }
    }
}
