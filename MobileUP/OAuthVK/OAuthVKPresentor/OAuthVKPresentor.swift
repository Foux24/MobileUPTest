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
    func dismissScreen() -> Void
    func getWarningAuthorisation() -> Void
}

// MARK: - OAuthVKPresentor
final class OAuthVKPresentor: OAuthVKPresentorOutout {

    /// Ссылка на роутер
    let router: OAuthVKRouterInput
    
    /// Инициализтор
    init(router: OAuthVKRouterInput) {
        self.router = router
    }

    /// Ссылка на MainViewController
    weak var mainViewController: UIViewController?
    
    /// Метод для перехода на MobileUPGalleryController
    func dismissScreen() -> Void {
        showDismissScreen()
    }
    
    /// Метод конфигурации запроса к VK.API
    func loadLoginVK(comlition: @escaping (URLRequest) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8002071"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html" ),
            URLQueryItem(name: "scope", value: "photos, groups"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "0")
        ]
        let request = URLRequest(url: urlComponents.url!)
        comlition(request)
    }
    
    /// Алерт с предупреждением о закрытии свайпом экрана авторизации
    func getWarningAuthorisation() -> Void {
        let alert = UIAlertController(title: "Warning", message: "Вы закрыли окно не авторизовавшись :(\nДля дальнейшей работы с приложением вам необходимо авторизоваться", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        mainViewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Private
private extension OAuthVKPresentor {
    
    /// Переход на следующий экран MobileUPGallery
    func showDismissScreen() -> Void {
        router.showDismissScreen()
    }
}
