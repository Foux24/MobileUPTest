//
//  MobileUPGalleryIntercator.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import UIKit

/// структурка для данных альбома
struct dataPhotoAlbum {
    let ownerID: String = "-128666765"
    let albumID: String = "266276915"
}

protocol MobileUPGalleryIntercatorInput {
    func loadRendomPhoto(completion: @escaping (Result<[Item], PhotoAlbumError>) -> Void)
}

// MARK: - SearchPhotoInteractor
class MobileUPGalleryIntercator: MobileUPGalleryIntercatorInput {

    let dataAlbum = dataPhotoAlbum()
    
    /// Сервис по загрузки данных
    private let service: NetworkServiceOutput
    
    init(service: NetworkServiceOutput) {
        self.service = service
    }
    
    /// Загруза рендомных фото
    func loadRendomPhoto(completion: @escaping (Result<[Item], PhotoAlbumError>) -> Void) {
        service.loadPhotoAlbumPromisURL(ownerID: dataAlbum.ownerID, albumID: dataAlbum.albumID)
            .then(on: DispatchQueue.global(), service.loadPhotoAlbumPromisData(_:))
            .then(service.loadPhotoAlbumPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response))
            }.catch { error in
                completion(.failure(.parseError))
            }
    }
}
