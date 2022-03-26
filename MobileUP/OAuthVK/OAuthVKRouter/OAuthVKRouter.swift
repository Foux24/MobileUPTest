//
//  OAuthVKRouter.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Протокол для общения роутера с презентором
protocol OAuthVKRouterInput {
    func showNextScreen() -> Void
}

// MARK: - OAuthVKRouter
class OAuthVKRouter: OAuthVKRouterInput {
    
    /// Пропертя с ViewController-ом
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с альбомом фотографий
    func showNextScreen() -> Void {
        let mobileUPGalleryViewController = MobileUPGalleryBuilder.build()
        mobileUPGalleryViewController.modalPresentationStyle = .fullScreen
        viewController?.present(mobileUPGalleryViewController, animated: true, completion: nil)
    }
}
