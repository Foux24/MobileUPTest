//
//  DetailPhotoBuilder.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

// MARK: - DetailPhotoBuilder
final class DetailPhotoBuilder {
    
    /// Билд контроллера
    static func build(data: ModelScreenDetailPhoto) -> UIViewController {
        let networkService = NetworkService()
        let interacor = DetailPhotoInteractor(service: networkService)
        let presenter = DetailPhotoPresentor(data: data, intercator: interacor)
        let viewController = DetailPhotoViewController(presentor: presenter)
        
        presenter.viewController = viewController
        return viewController
    }
}
