//
//  MobileUPGalleryIntercator.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// Проктол взаимодействия с интерактором
protocol MobileUPGalleryIntercatorInput {
    func loadRendomPhoto(dataAlbum: DataPhotoAlbum, completion: @escaping (Result<[Photo], ErrorVK>) -> Void)
}

// MARK: - SearchPhotoInteractor
final class MobileUPGalleryIntercator: MobileUPGalleryIntercatorInput {

    /// Сервис по загрузки данных
    private let service: NetworkServiceOutput
    
    /// Инициализтор
    init(service: NetworkServiceOutput) {
        self.service = service
    }
    
    /// Загруза  фото из альбома
    func loadRendomPhoto(dataAlbum: DataPhotoAlbum, completion: @escaping (Result<[Photo], ErrorVK>) -> Void) {
        service.loadPhotoAlbumPromisURL(ownerID: dataAlbum.ownerID, albumID: dataAlbum.albumID)
            .then(on: DispatchQueue.global(), service.loadPhotoAlbumPromisData(_:))
            .then(service.loadPhotoAlbumPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
}
