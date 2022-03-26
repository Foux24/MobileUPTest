//
//  OAuthVKPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Протокол для общения презентора с контроллером
protocol OAuthVKPresentorOutout: AnyObject {
    func loadLoginVK(comlition: @escaping (URLRequest) -> Void)
    func showMobileUPGallery() -> Void
}

// MARK: - OAuthVKPresentor
final class OAuthVKPresentor: OAuthVKPresentorOutout {

    /// Ссылка на роутер
    let router: OAuthVKRouterInput
    
    /// Инициализтор
    init(router: OAuthVKRouterInput) {
        self.router = router
    }

    /// Метод для перехода
    func showMobileUPGallery() -> Void {
        showNextController()
    }
    
    /// Метод конфигурации запроса к VK.API
    func loadLoginVK(comlition: @escaping (URLRequest) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8002144"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html" ),
            URLQueryItem(name: "scope", value: "offline, friends, photos, groups, wall"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        let request = URLRequest(url: urlComponents.url!)
        comlition(request)
    }
}

// MARK: - Private
private extension OAuthVKPresentor {
    
    /// Переход на следующий экран MobileUPGallery
    func showNextController() {
        router.showNextScreen()
    }
}
