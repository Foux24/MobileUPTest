//
//  ModelDataSession.swift
//  MobileUP
//
//  Created by Vitalii Sukhoroslov on 27.03.2022.
//

import Foundation

/// Определим модельку для данных сессии
struct DataSession: Codable {
    
    /// Свойство для токена
    var token: String?
    
    /// Свойство для userId
    var userId: Int?
}
