//
//  MobileUPGalleryPresentor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Проктол с входными параметрами для взаимодействия с ViewController
protocol MobileUPGalleryPresentorInput: AnyObject {
    var photos: [ModelSortedPhoto] { get set }
}

/// Проктол с выходными параметрами для взаимодействия с ViewController
protocol MobileUPGalleryPresentorOutput: AnyObject {
    func getPhotoAlbum() -> Void
    var fileManager: HashPhotoService? { get set }
}

// MARK: - MobileUPGalleryPresentor
final class MobileUPGalleryPresentor: MobileUPGalleryPresentorOutput {

    /// Интерактор
    private let interactor: MobileUPGalleryIntercatorInput
    
    /// Вью Контроллер
    weak var viewController: (UIViewController & MobileUPGalleryPresentorInput)?
    
    /// Для кеша изоборажений
    var fileManager: HashPhotoService?
    
    /// Инициализтор
    init(interactor: MobileUPGalleryIntercatorInput) {
        self.interactor = interactor
    }
    
    /// Метод загрузки фото альбома
    func getPhotoAlbum() -> Void {
        interactor.loadRendomPhoto { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let photos):
                self.viewController?.photos = self.sortPhoto(by: .r, from: photos)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Метод сортировки фото по передаваемому типу
    func sortPhoto(by sizeType: Size.EnumType, from array: [Item]) -> [ModelSortedPhoto] {
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
}
