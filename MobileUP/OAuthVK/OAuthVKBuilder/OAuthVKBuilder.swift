//
//  OAuthVKBuilder.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

// MARK: - OAuthVKBuilder
final class OAuthVKBuilder {
    
    /// Билд контроллера для авторизации в VK
    static func build(controller: UIViewController) -> UIViewController {
        let router = OAuthVKRouter()
        let presenter = OAuthVKPresentor(router: router)
        let viewController = OAuthVKViewController(presentor: presenter)
        
        router.viewController = viewController
        router.mainViewController = controller
        presenter.mainViewController = controller
        
        return viewController
    }
}
