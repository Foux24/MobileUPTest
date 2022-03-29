//
//  MainScreenRouter.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 28.03.2022.
//

import UIKit

/// Протокол для общения роутера с презентором
protocol MainScreenRouterInput {
    func showScreenOAuth(mainViewController controller: UIViewController) -> Void
    func showScreenMobileUPGallery() -> Void
}

// MARK: - MainScreenRouter
final class MainScreenRouter: MainScreenRouterInput {
    
    /// ссылка на MainScreenViewController
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с авторизацией
    func showScreenOAuth(mainViewController controller: UIViewController) -> Void {
        let oAuthController = OAuthVKBuilder.build(controller: controller)
        viewController?.navigationController?.showDetailViewController(oAuthController, sender: .none)
    }
    
    /// Переход на контроллер с альбомом фотографий
    func showScreenMobileUPGallery() -> Void {
        let mobileUPGalleryViewController = MobileUPGalleryBuilder.build()
        viewController?.navigationController?.pushViewController(mobileUPGalleryViewController, animated: true)
    }
}
