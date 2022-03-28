//
//  OAuthVKRouter.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Протокол для общения роутера с презентором
protocol OAuthVKRouterInput {
    func showDismissScreen() -> Void
}

// MARK: - OAuthVKRouter
class OAuthVKRouter: OAuthVKRouterInput {
    
    /// Пропертя с ViewController-ом
    weak var viewController: UIViewController?
    
    /// Ссылка на главный экран
    weak var mainViewController: UIViewController?
    
    /// Переход на контроллер с альбомом фотографий
    func showDismissScreen() -> Void {
        viewController?.dismiss(animated: true, completion: {
            let mobileUPGalleryViewController = MobileUPGalleryBuilder.build()
            self.mainViewController?.navigationController?.pushViewController(mobileUPGalleryViewController, animated: true)
        })
    }
}
