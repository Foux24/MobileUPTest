//
//  DetailPhotoInteractor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

/// Проктол взаимодействия с интерактором
protocol DetailPhotoInteractorInput: AnyObject {
    func savePhoto(dataPhoto: ModelSortedPhoto, completion: @escaping (Result<JsonModelPhotoCopy, ErrorVK>) -> Void)
}

// MARK: - DetailPhotoInteractor
final class DetailPhotoInteractor: DetailPhotoInteractorInput {

    /// Сервис по загрузки данных
    private let service: NetworkServiceOutput
    
    /// Инициализтор
    init(service: NetworkServiceOutput) {
        self.service = service
    }
    
    /// Сохранения фотографии в альбом сохраненные
    func savePhoto(dataPhoto: ModelSortedPhoto, completion: @escaping (Result<JsonModelPhotoCopy, ErrorVK>) -> Void) {
        service.savePhotoPromisURL(ownerID: String(dataPhoto.ownerID), idPhoto: String(dataPhoto.id))
            .then(on: DispatchQueue.global(), service.savePhotoPromisData(_:))
            .then(service.savePhotoPromiseParsed(_:))
            .done(on: DispatchQueue.main) { response in
                completion(.success(response))
            }.catch { error in
                completion(.failure(error as! ErrorVK))
            }
    }
}
