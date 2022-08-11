//
//  AppCoordinator.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit

final class AppCoordinator: Coordinator {

    private let window: UIWindow?
    private let designToken: DesignToken
    private let navigationController = UINavigationController()

    // MARK: - Initializers

    init(
        window: UIWindow?,
        designToken: DesignToken
    ) {
        self.window = window
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

    private func showClassifiedAds() {}

    private func showClassifiedAdDetails(_ classifiedAd: ClassifiedAd) {}
}
