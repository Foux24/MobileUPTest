//
//  ErrorHandler.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

struct ErrorHandler {
    /// Переобразуем переданную ошибку в текст
    func errorMassage(error: PhotoAlbumError) -> String {
        switch error {
        case .error: return "Ошибка не известна, попробуйте позже"
        case .accessDenied: return "Отказанно в доступе"
        case .errorTask: return "Ошибка Задачи"
        case .parseError: return "Ошибка парсинга"
        default: return "Не известная ошибка"
        }
    }
}
