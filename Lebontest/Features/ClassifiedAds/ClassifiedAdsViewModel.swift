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

    enum State {
        case success([AdCellViewModel])
        case loading
        case error(String)
    }

    // MARK: - Properties

    private let classifiedAdsRepository: ClassifiedAdsRepositoryType
    private let categoryMapperProvider: CategoryMapperProviderType
    private let numberFormatter: NumberFormatterType
    private let imageProvider: ImageProviderType

    weak var delegate: ClassifiedAdsViewModelDelegate?

    // MARK: - Inputs

    func fetch() {
        bind?(.loading)

        classifiedAdsRepository.get(
            onComplete: { [weak self] classifiedAds in
                self?.categoryMapperProvider.get { [weak self] categoryMapper in
                    let cellViewModels = self?.buildCellViewModels(
                        classifiedAds: classifiedAds,
                        categoryMapper: categoryMapper
                    ) ?? []
                    self?.bind?(.success(cellViewModels))
                }
            },
            onError: { error in
                // TODO: - Handle error
            }
        )
    }

    // MARK: - Outputs

    let navigationTitle: String
    var bind: ((State) -> Void)?

    // MARK: - Initializers

    init(
        classifiedAdsRepository: ClassifiedAdsRepositoryType,
        categoryMapperProvider: CategoryMapperProviderType,
        numberFormatter: NumberFormatterType,
        imageProvider: ImageProviderType
    ) {
        self.classifiedAdsRepository = classifiedAdsRepository
        self.categoryMapperProvider = categoryMapperProvider
        self.numberFormatter = numberFormatter
        self.imageProvider = imageProvider

        navigationTitle = Translation.ClassifiedAds.navigationTitle
    }

    // MARK: - Private

    private func selectClassifiedAd(_ classifiedAd: ClassifiedAd) {
        delegate?.didSelect(classifiedAd: classifiedAd, from: self)
    }

    private func buildCellViewModels(classifiedAds: [ClassifiedAd], categoryMapper: CategoryMapper) -> [AdCellViewModel] {
        let numberFormatter = self.numberFormatter
        let imageProvider = self.imageProvider

        let cellViewModels = classifiedAds.map { [weak self] classifiedAd -> AdCellViewModel in
            var classifiedAd = classifiedAd
            classifiedAd.categoryName = categoryMapper.getCategory(id: classifiedAd.categoryId)?.name

            let onSelect: (() -> Void) = {
                self?.selectClassifiedAd(classifiedAd)
            }
            let cellViewModel = AdCellViewModel(
                classifiedAd: classifiedAd,
                numberFormatter: numberFormatter,
                imageProvider: imageProvider,
                onSelect: onSelect
            )
            return cellViewModel
        }

        return cellViewModels
    }
}
