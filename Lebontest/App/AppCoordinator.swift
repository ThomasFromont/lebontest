//
//  AppCoordinator.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow?
    private let httpClient: HTTPClientType
    private let categoryMapperProvider: CategoryMapperProviderType
    private let numberFormatter: NumberFormatterType
    private let imageProvider: ImageProviderType
    private let designToken: DesignToken
    private let navigationController = UINavigationController()

    // MARK: - Initializers

    init(
        window: UIWindow?,
        httpClient: HTTPClientType,
        numberFormatter: NumberFormatter,
        imageProvider: ImageProviderType,
        designToken: DesignToken
    ) {
        self.window = window
        self.httpClient = httpClient
        self.categoryMapperProvider = CategoryMapperProvider(categoriesRepository: CategoriesRepository(httpClient: httpClient))
        self.numberFormatter = numberFormatter
        self.imageProvider = imageProvider
        self.designToken = designToken
    }

    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        showClassifiedAds()
    }

    func close(animated: Bool, completion: (() -> Void)?) {
        assertionFailure("The close(animated:completion:) is not implemented by the AppCoordinator")
        completion?()
    }

    private func showClassifiedAds() {
        let viewModel = ClassifiedAdsViewModel(
            classifiedAdsRepository: ClassifiedAdsRepository(httpClient: httpClient),
            categoryMapperProvider: categoryMapperProvider,
            numberFormatter: numberFormatter,
            imageProvider: imageProvider
        )
        viewModel.delegate = self
        let viewController = ClassifiedAdsViewController(viewModel: viewModel, designToken: designToken)
        navigationController.viewControllers = [viewController]
    }

    private func showClassifiedAdDetails(_ classifiedAd: ClassifiedAd) {
        let viewModel = ClassifiedAdDetailsViewModel(
            classifiedAd: classifiedAd,
            categoryMapperProvider: categoryMapperProvider,
            numberFormatter: numberFormatter,
            imageProvider: imageProvider
        )
        viewModel.delegate = self
        let viewController = ClassifiedAdDetailsViewController(viewModel: viewModel, designToken: designToken)
        viewController.modalPresentationStyle = .fullScreen
        navigationController.present(viewController, animated: true, completion: nil)
    }
}

extension AppCoordinator: ClassifiedAdsViewModelDelegate {
    func didSelect(classifiedAd: ClassifiedAd, from: ClassifiedAdsViewModel) {
        showClassifiedAdDetails(classifiedAd)
    }
}

extension AppCoordinator: ClassifiedAdDetailsViewModelDelegate {
    func didSelectClose(from viewModel: ClassifiedAdDetailsViewModel) {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
