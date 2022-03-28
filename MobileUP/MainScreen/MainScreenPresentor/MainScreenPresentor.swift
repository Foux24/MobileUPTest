//
//  MainScreenPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Протокол для общения презентора с mainViewController
protocol MainScreenPresentorOutput: AnyObject {
    func showScreenOAuth(mainViewController controller: UIViewController) -> Void
    func showScreenMobileUPGallery() -> Void
    func getStatusToken(complition: @escaping () -> Void)
    var statusToken: Int? { get set }
}

// MARK: - MainScreenPresentor
final class MainScreenPresentor: MainScreenPresentorOutput {
    
    /// Status Token
    var statusToken: Int?
    
    /// Интерактор
    private let interactor: MainScreenInteractorInput
    
    /// Роутер
    private let router: MainScreenRouterInput
    
    /// Инициализтор
    init(interactor: MainScreenInteractorInput, router: MainScreenRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    /// Метод загрузки сервисного токена
    func getStatusToken(complition: @escaping () -> Void) {
        interactor.validationToken() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let status):
                self.statusToken = status.success
                complition()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Переход на экран авторизации в VK.com
    func showScreenOAuth(mainViewController controller: UIViewController) -> Void {
        self.transitionToNextScreenOAuth(mainViewController: controller)
    }
    
    /// Переход на экран с галлереей фотографий
    func showScreenMobileUPGallery() -> Void {
        transitionToNextScreenMobileUPGallery()
    }
}

// MARK: - Private
private extension MainScreenPresentor {
    
    /// Переход на экран авторизации в VK.com
    func transitionToNextScreenOAuth(mainViewController controller: UIViewController) {
        self.router.showScreenOAuth(mainViewController: controller)
    }
    
    /// Переход на экран с галлереей фотографий
    func transitionToNextScreenMobileUPGallery() {
        self.router.showScreenMobileUPGallery()
    }
}
