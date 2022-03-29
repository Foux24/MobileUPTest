//
//  MainScreenInteractor.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import UIKit

/// Проктол взаимодействия с интерактором
protocol MainScreenInteractorInput {
    func validationToken(completion: @escaping (Result<ValidToken, ErrorVK>) -> Void)
}

// MARK: - MainScreenInteractor
final class MainScreenInteractor: MainScreenInteractorInput {

    /// Сервис по загрузки данных
    private let service: NetworkServiceOutput
    
    /// Инициализтор
    init(service: NetworkServiceOutput) {
        self.service = service
    }
    
    /// Проверка валдиности тококена
    func validationToken(completion: @escaping (Result<ValidToken, ErrorVK>) -> Void) {
        if Session.instance.session.token != nil {
            service.validationTokenPromisURL()
                .then(on: DispatchQueue.global(), service.validationTokenPromisData(_:))
                .then(service.validationTokenPromiseParsed(_:))
                .done(on: DispatchQueue.main) { response in
                    completion(.success(response))
                }.catch { error in
                    completion(.failure(error as! ErrorVK))
                }
        }
    }
}
