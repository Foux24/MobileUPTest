//
//  MobileUpGalleryRouter.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Протокол для общения роутера с презентором
protocol MobileUpGalleryRouterInput {
    func showNextScreen(data: ModelScreenDetailPhoto) -> Void
    func logaut() -> Void
}

// MARK: - MobileUpGalleryRouter
final class MobileUpGalleryRouter: MobileUpGalleryRouterInput {
    
    /// Пропертя с ViewController-ом
    weak var viewController: UIViewController?
    
    /// Переход на контроллер с альбомом фотографий
    func showNextScreen(data: ModelScreenDetailPhoto) -> Void {
        let vc = DetailPhotoBuilder.build(data: data)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// Выход на рут контроллер
    func logaut() -> Void {
        Session.instance.cleanSession()
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
