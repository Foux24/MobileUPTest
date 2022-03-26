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
        let presenter = MobileUPGalleryPresentor(interactor: interacor)
        let viewController = MobileUPGalleryViewController(presentor: presenter)
        
        presenter.viewController = viewController
        return viewController
    }
}
