//
//  NetworkService.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 26.03.2022.
//

import Foundation
import PromiseKit

/// Протокол взаимодействия с NetworkService
protocol NetworkServiceOutput: AnyObject {
    func loadPhotoAlbumPromisURL(ownerID: String, albumID: String) -> Promise<URL>
    func loadPhotoAlbumPromisData(_ url: URL) -> Promise<Data>
    func loadPhotoAlbumPromiseParsed(_ data: Data) -> Promise<[Photo]>
    
    func savePhotoPromisURL(ownerID: String, idPhoto: String) -> Promise<URL>
    func savePhotoPromisData(_ url: URL) -> Promise<Data>
    func savePhotoPromiseParsed(_ data: Data) -> Promise<JsonModelPhotoCopy>
        
    func validationTokenPromisURL() -> Promise<URL>
    func validationTokenPromisData(_ url: URL) -> Promise<Data>
    func validationTokenPromiseParsed(_ data: Data) -> Promise<ValidToken>
}

// MARK: - Request методы к Vk.API
/// Список методов
fileprivate enum TypeMethods: String {
    case photosGetAll = "/method/photos.get"
    case photosCopy = "/method/photos.copy"
    case validationToken = "/method/secure.checkToken"
}

/// Cписок типов запросов
fileprivate enum TypeRequest: String {
    case get = "GET"
}

// MARK: - Error
/// Список  ошибок при составлении запросе
enum ErrorRequest: Error {
    case parseError
    case errorTask
}

// MARK: - NetworkService
final class NetworkService: NetworkServiceOutput {
    
    /// URLSession
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    /// Протокол запроса
    private let scheme = "https"
    
    /// Адресс сервера
    private let host = "api.vk.com"
    
    /// Декодер
    private let decoder = JSONDecoder()
    
    // MARK: - Методы для загрузки фото альбома
    /// Конфигурации УРЛ
    func loadPhotoAlbumPromisURL(ownerID: String, albumID: String) -> Promise<URL> {
        
        let token = Session.instance.session.token ?? ""
        
        let params: [String: String] = ["owner_id" : ownerID,
                                        "album_id" : albumID
        ]
        let urlConfig = self.configureUrl(token: token,
                                          method: .photosGetAll,
                                          httpMethod: .get,
                                          params: params)
        return Promise { resolver in
            let url = urlConfig
            resolver.fulfill(url)
        }
    }
    
    /// Конфигурация ответа от сервера в дату
    func loadPhotoAlbumPromisData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    resolver.reject(ErrorRequest.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    /// Парсинг
    func loadPhotoAlbumPromiseParsed(_ data: Data) -> Promise<[Photo]> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JsonModelPhotoAlbum.self, from: data).response.items
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
    
    // MARK: - Метод сохранения фото в альбом сохраненные
    /// Конфигурации УРЛ
    func savePhotoPromisURL(ownerID: String, idPhoto: String) -> Promise<URL> {
        
        let token = Session.instance.session.token ?? ""
        
        let params: [String: String] = ["owner_id" : ownerID,
                                        "photo_id" : idPhoto
        ]
        let urlConfig = self.configureUrl(token: token,
                                          method: .photosCopy,
                                          httpMethod: .get,
                                          params: params)
        return Promise { resolver in
            let url = urlConfig
            resolver.fulfill(url)
        }
    }
    
    /// Конфигурация ответа от сервера в дату
    func savePhotoPromisData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    resolver.reject(ErrorRequest.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    /// Парсинг
    func savePhotoPromiseParsed(_ data: Data) -> Promise<JsonModelPhotoCopy> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JsonModelPhotoCopy.self, from: data)
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
    
    // MARK: - Проверка валидности токена
    /// Конфигурации УРЛ
    func validationTokenPromisURL() -> Promise<URL> {
        
        let appData = DataAppVK()
        
        let token = Session.instance.session.token ?? ""
        
        let params: [String: String] = ["token" : token]
        
        let urlConfig = self.configureUrl(token: appData.serviceToken,
                                          method: .validationToken,
                                          httpMethod: .get,
                                          params: params)
        print(urlConfig)
        return Promise { resolver in
            let url = urlConfig
            resolver.fulfill(url)
        }
    }
    
    /// Конфигурация ответа от сервера в дату
    func validationTokenPromisData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    resolver.reject(ErrorRequest.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    /// Парсинг
    func validationTokenPromiseParsed(_ data: Data) -> Promise<ValidToken> {
        return Promise { resolver in
            do {
                let response = try decoder.decode(JsonModelValidationToken.self, from: data).response
                resolver.fulfill(response)
            } catch {
                let response = try decoder.decode(Errors.self, from: data).error
                resolver.reject(response)
            }
        }
    }
}

// MARK: - Private
private extension NetworkService {
    
    /// Конфигуратор УРЛ
    func configureUrl(token: String,
                      method: TypeMethods,
                      httpMethod: TypeRequest,
                      params: [String: String]) -> URL {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "access_token", value: token))
        queryItems.append(URLQueryItem(name: "v", value: "5.81"))
        for (param, value) in params {
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            fatalError("URL is invalid")
        }
        return url
    }
}
