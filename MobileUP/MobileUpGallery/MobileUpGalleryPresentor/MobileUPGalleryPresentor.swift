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
    func showDetailPhoto() -> Void
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
                print(error)
            }
        }
    }
    
    /// Метод для перехода
    func showDetailPhoto() -> Void {
        self.showNextController()
    }
}

private extension MobileUPGalleryPresentor {
    
    /// Метод сортировки фото по передаваемому типу
    func sortPhoto(by sizeType: Size.EnumType, from array: [Photo]) -> [ModelSortedPhoto] {
        var objectLinks: [ModelSortedPhoto] = []
        for model in array {
            for size in model.sizes {
                if size.type == sizeType {
                    let modelPhoto = ModelSortedPhoto(url: size.url, dateCreate: model.date)
                    objectLinks.append(modelPhoto)
                }
            }
        }
        return objectLinks
    }
    
    /// Переход на следующий экран DetailPhoto
    func showNextController() {
        self.router.showNextScreen()
    }
}
