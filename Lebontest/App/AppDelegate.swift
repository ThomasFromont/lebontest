//
//  AppDelegate.swift
//  Lebontest
//
//  Created by Thomas Fromont on 11/08/2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(
            window: window,
            httpClient: HTTPClient(),
            designToken: DesignToken.shared
        )
        coordinator?.start()

        return true
    }
}
