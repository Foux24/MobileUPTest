//
//  MobileUpGalleryRouter.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Протокол для общения роутера с презентором
protocol MobileUpGalleryRouterInput {
    func showNextScreen() -> Void
}

// MARK: - OAuthVKRouter
class MobileUpGalleryRouter: MobileUpGalleryRouterInput {
    
    /// Пропертя с ViewController-ом
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с альбомом фотографий
    func showNextScreen() -> Void {
        let vc = DetailPhotoViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
