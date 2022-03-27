//
//  MobileUPGalleryPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Протокол с входными параметрами для взаимодействия с ViewController
protocol MobileUPGalleryPresentorInput: AnyObject {
    var photos: [ModelSortedPhoto] { get set }
}

/// Протокол с выходными параметрами для взаимодействия с ViewController
protocol MobileUPGalleryPresentorOutput: AnyObject {
    func getPhotoAlbum() -> Void
    func showDetailPhoto(data: ModelScreenDetailPhoto) -> Void
    var fileManager: HashPhotoService? { get set }
}

// MARK: - MobileUPGalleryPresentor
final class MobileUPGalleryPresentor: MobileUPGalleryPresentorOutput {

    /// Данные альбома
    private let dataAlbum = DataPhotoAlbum()
    
    /// Интерактор
    private let interactor: MobileUPGalleryIntercatorInput
    
    /// Роутер
    private let router: MobileUpGalleryRouterInput
    
    /// Обработчик ошибок
    private let errorHandler = ErrorHandler()
    
    /// Вью Контроллер
    weak var viewController: (UIViewController & MobileUPGalleryPresentorInput)?
    
    /// Для кеша изоборажений
    var fileManager: HashPhotoService?
    
    /// Инициализтор
    init(interactor: MobileUPGalleryIntercatorInput, router: MobileUpGalleryRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    /// Метод загрузки фото альбома
    func getPhotoAlbum() -> Void {
        interactor.loadRendomPhoto(dataAlbum: dataAlbum) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.viewController?.photos = self.sortPhoto(by: .r, from: photos)
            case .failure(let error):
                self.getErrorAlertSavePhoto(message: self.errorHandler.errorMassage(error: error))
            }
        }
    }
    
    /// Метод для перехода
    func showDetailPhoto(data: ModelScreenDetailPhoto) -> Void {
        self.showNextController(data: data)
    }
}

private extension MobileUPGalleryPresentor {
    
    /// Метод сортировки фото по передаваемому типу
    func sortPhoto(by sizeType: Size.EnumType, from array: [Photo]) -> [ModelSortedPhoto] {
        var objectLinks: [ModelSortedPhoto] = []
        for model in array {
            for size in model.sizes {
                if size.type == sizeType {
                    let modelPhoto = ModelSortedPhoto(url: size.url, dateCreate: model.date, id: model.id, ownerID: model.ownerID)
                    objectLinks.append(modelPhoto)
                }
            }
        }
        return objectLinks
    }
    
    /// Переход на следующий экран DetailPhoto
    func showNextController(data: ModelScreenDetailPhoto) {
        self.router.showNextScreen(data: data)
    }
    
    /// Алерт с ошибкой при загрузки фото
    func getErrorAlertSavePhoto(message: String) -> Void {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
}
