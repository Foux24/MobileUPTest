//
//  MainScreenBuilder.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - MainScreenBuilder
final class MainScreenBuilder {
    
    /// Билд контроллера
    static func build() -> UIViewController {
        let router = MainScreenRouter()
        let networkService = NetworkService()
        let interactor = MainScreenInteractor(service: networkService)
        let presenter = MainScreenPresentor(interactor: interactor, router: router)
        let viewController = MainScreenViewController(presentor: presenter)
        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
