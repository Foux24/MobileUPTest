//
//  MobileUPGalleryBuilder.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - MobileUPGalleryBuilder
class MobileUPGalleryBuilder {
    
    /// Билд контроллера
    static func build() -> UIViewController {
        let networkService = NetworkService()
        let interacor = MobileUPGalleryIntercator(service: networkService)
        let router = MobileUpGalleryRouter()
        let presenter = MobileUPGalleryPresentor(interactor: interacor, router: router)
        let viewController = MobileUPGalleryViewController(presentor: presenter)

        router.viewController = viewController
        presenter.viewController = viewController
        return viewController
    }
}
